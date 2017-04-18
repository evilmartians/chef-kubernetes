require 'yaml'
require 'json'
require 'logger'
require 'openssl'
require 'tempfile'
require 'chef'

LOGGER           = Logger.new(STDOUT)
CONFIG_FILE      = ENV['CONFIG_FILE'] || File.expand_path("#{__dir__}/config.yaml")
CONFIG           = YAML.load_file(CONFIG_FILE)
WORK_DIR         = ENV['WORK_DIR'] || File.expand_path("#{Dir.pwd}/ssl")
CHEF_DIR         = ENV['CHEF_DIR'] || File.expand_path(__dir__ + '/.chef')
CHEF_SECRET_FILE = ENV['CHEF_SECRET_FILE'] || File.join(CHEF_DIR, 'secret.pem')

# Migrator settings
DATA_BAG         = ENV['CHEF_DATA_BAG'] || 'kubernetes'
CHEF_NODE        = ENV['CHEF_NODE'] || ENV['USER']
CLUSTER_NAME     = ENV['CLUSTER_NAME']
CHEF_ORG         = ENV['CHEF_ORG']

def pem_path(name = 'ca', ext = 'pem')
  File.join(WORK_DIR, "#{name}#{ext}")
end

def cert(name)
  OpenSSL::X509::Certificate.new(File.read("#{WORK_DIR}/#{name}.pem"))
rescue
  false
end

def common_name(crt)
  cn = crt.subject.to_a.find {|i| i.include? "CN"}
  Array === cn ? cn[1] : ""
end

def subject_alt_names(crt)
  san = crt.extensions.find {|e| e.oid == "subjectAltName"}
  if OpenSSL::X509::Extension === san
    san = san.value.split(',').map {|i| i.split(':')[1].to_s}
    san = [] if san == [""]
    return san
  end
  return []
end

def verified_by_ca?(crt, ca = "#{WORK_DIR}/ca.pem")
  cert_store = OpenSSL::X509::Store.new
  cert_store.set_default_paths
  cert_store.add_file ca
  cert_store.verify crt
end

def active?(crt)
  crt.not_before < Time.now && crt.not_after > Time.now
end

def ca?(crt)
  usage = crt.extensions.find {|e| e.oid == "basicConstraints"}.to_s
  usage.include?('CA:TRUE')
end

def valid?(name, ca = "#{WORK_DIR}/ca.pem")
  return false unless account_files(name).all?(&:exist?)
  return false unless crt = cert(name)
  return false unless active?(crt)
  return false unless verified_by_ca?(crt, ca)
  return true if      ca?(crt)
  return false unless subject_alt_names(crt).sort.uniq == CONFIG['accounts'][name]['hosts'].sort.uniq
  return false unless common_name(crt) == CONFIG['accounts'][name]['cn']
  true
end

def account_files(name)
  ['.pem', '.csr', '-key.pem', '-csr.json'].map {|ext| Pathname.new("#{WORK_DIR}/#{name}#{ext}")}
end

def gencsr(name, cn, hosts = [])
  gencsr!(name, cn, hosts) unless valid?(name)
end

def gencsr!(name, cn, hosts)
  LOGGER.info "Generating ca-csr.json with algo #{CONFIG['csr']['key']['algo']} and size #{CONFIG['csr']['key']['size']}"
  names = CONFIG['names']['common'].merge(CONFIG['names'][name])
  content = CONFIG['csr'].merge('hosts' => hosts, 'CN' => cn, 'names' => [names])
  LOGGER.debug "ca-csr.json: #{content.to_json}"
  write_file("#{name}-csr", content)
end

def write_file(file, content)
  file += '.json' if File.extname(file).empty?
  file = File.open("#{WORK_DIR}/#{file}", "w")
  content = content.to_json if File.extname(file) == '.json'
  file.write content
  file.flush
rescue => e
  LOGGER.fatal "#{file} was not written because of #{e.message}"
  exit 1
end

def generate(name)
  generate!(name) unless valid?(name)
end

def generate!(name)
  LOGGER.info "Generating the #{name} client certificate and private key..."
  system("cfssl gencert -ca=#{WORK_DIR}/ca.pem -ca-key=#{WORK_DIR}/ca-key.pem -config=#{WORK_DIR}/ca-config.json -profile=kubernetes #{WORK_DIR}/#{name}-csr.json | cfssljson -bare #{WORK_DIR}/#{name}")
rescue => e
  LOGGER.fatal "Command #{command} failed with #{e.message}"
  exit 1
end

def chef_secret(pathname = CHEF_SECRET_FILE)
  Chef::EncryptedDataBagItem.load_secret(pathname)
rescue => e
  LOGGER.fatal "Chef secret file #{pathname} could not be parsed: #{e.message}. Exiting..."
  exit(1)
end

def encrypt(name, secret)
  cert, key = ['.pem', '-key.pem'].map { |ext| File.read(pem_path(name, ext))}
  hash = { 'id' => "#{name}_ssl", 'public_key' => cert, 'private_key' => key}
  data_bag = Chef::DataBagItem.from_hash(hash)
  Chef::EncryptedDataBagItem.encrypt_data_bag_item(data_bag, secret)
end

desc "Generate all the keys"
task default: ['ca:generate'] + CONFIG['accounts'].map {|name, data| "#{name}:generate"}

desc "Generate all the keys and format encrypted databags"
task encrypt_all: ['ca:encrypt'] + CONFIG['accounts'].map {|name, data| "#{name}:encrypt"} do
  LOGGER.info "Now move #{WORK_DIR}/{ca_ssl.json,#{CONFIG['accounts'].map {|name, data| name + '_ssl.json'}.join(',')}} to $chef_databags_folder/kubernetes"
end

namespace :ca do

  desc 'Certification authority configuration'
  task :config do
    filename = "#{WORK_DIR}/ca-config.json"
    next if File.exist?(filename)
    LOGGER.info "Generating ca-config.json with expiration period #{CONFIG['ca_config']['signing']['default']['expiry']}"
    ca_config = CONFIG['ca_config']
    LOGGER.debug "ca_config.json: #{ca_config.to_json}"
    write_file('ca-config', ca_config)
  end

  desc 'Certification authority CSR'
  task :csr => :config do
    gencsr('ca', 'Kubernetes')
  end

  desc 'Generate a CA certificate and private key'
  task :generate => :csr do
    cert_file = "#{WORK_DIR}/ca.pem"
    key_file = "#{WORK_DIR}/ca-key.pem"
    next if File.exist?(key_file) && File.exist?(cert_file)
    LOGGER.info 'Initializing bare CA'
    system("cfssl gencert -initca #{WORK_DIR}/ca-csr.json | cfssljson -bare #{WORK_DIR}/ca")
  end

  desc 'Generate encrypted CA data bag'
  task :encrypt => :generate do
    LOGGER.info("Generating encrypted data bag for CA...")
    write_file('ca_ssl', encrypt('ca', chef_secret(CHEF_SECRET_FILE)))
  end
end

CONFIG['accounts'].each do |name, data|

  namespace name.to_sym do

    desc "Create the #{name} client certificate signing request"
    task :csr do
      gencsr(name, data['cn'], data['hosts'])
    end

    desc "Generate the #{name} client certificate and private key"
    task :generate => :csr do
      generate(name)
    end

    desc "Create encrypted databag for #{name} keypair"
    task :encrypt => :generate do
      LOGGER.info("Generating encrypted data bag for #{name}...")
      write_file("#{name}_ssl", encrypt(name, chef_secret(CHEF_SECRET_FILE)))
    end

  end
end

namespace :migrate do
  desc "Migrate SSL keypairs from old scheme"
  task :all => ['ca:config'] do
    secret = chef_secret
    Chef::Config.config_file = File.expand_path(Pathname(CHEF_DIR)) + '/knife.rb'
    Chef::Config.chef_server_url = "https://api.opscode.com/organizations/#{CHEF_ORG}"
    Chef::Config.client_key = File.expand_path(Pathname("#{CHEF_DIR}/#{CHEF_NODE}.pem"))
    Chef::Config.node_name = CHEF_NODE
    LOGGER.info("Obtaining data bag #{DATA_BAG}/#{CLUSTER_NAME}_cluster_ssl from #{Chef::Config.chef_server_url}...")
    begin
      data_bag = Chef::EncryptedDataBagItem.load(DATA_BAG, "#{CLUSTER_NAME}_cluster_ssl", secret)
    rescue => e
      LOGGER.fatal("Obtaining data bag #{DATA_BAG}/#{CLUSTER_NAME}_cluster_ssl from #{Chef::Config.chef_server_url} failed with #{e.message}")
      exit(1)
    end
    write_file('ca.pem', data_bag['client_ca_file'])
    write_file('ca-key.pem', data_bag['ca_key_file'])
    write_file('apiserver.pem', data_bag['tls_cert_file'])
    write_file('apiserver-key.pem', data_bag['tls_private_key_file'])
    LOGGER.info("Generating fake csr for apiserver")
    crt = cert('apiserver')
    CONFIG['accounts']['apiserver']['cn'] = common_name(crt)
    CONFIG['accounts']['apiserver']['hosts'] = subject_alt_names(crt).sort.uniq
    begin
      gencsr('apiserver', common_name(crt), subject_alt_names(crt).sort.uniq)
      gencsr('ca', 'Kubernetes')
      api_json = "cfssl gencert -ca=#{WORK_DIR}/ca.pem -ca-key=#{WORK_DIR}/ca-key.pem -config=#{WORK_DIR}/ca-config.json -profile=kubernetes #{WORK_DIR}/apiserver-csr.json"
      ca_json = "cfssl gencert -initca #{WORK_DIR}/ca-csr.json"
      api_json = JSON.parse(`#{api_json}`)
      ca_json = JSON.parse(`#{ca_json}`)
      write_file('apiserver.csr', api_json['csr'])
      write_file('ca.csr', ca_json['csr'])
    rescue => e
      LOGGER.fatal("Can't write #{WORK_DIR}/apiserver.csr because of #{e.message}")
      exit(1)
    end
    LOGGER.info("Writing config file for verification to: #{WORK_DIR}/migrator-config.yaml")
    write_file('migrator-config.yaml', CONFIG.to_yaml)
  end
end
