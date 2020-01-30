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
  cn = crt.subject.to_a.find { |i| i.include? 'CN' }
  Array === cn ? cn[1] : ''
end

def subject_alt_names(crt)
  san = crt.extensions.find { |e| e.oid == 'subjectAltName' }
  if OpenSSL::X509::Extension === san
    san = san.value.split(',').map { |i| i.split(':')[1].to_s }
    san = [] if san == ['']
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
  usage = crt.extensions.find { |e| e.oid == 'basicConstraints' }.to_s
  usage.include?('CA:TRUE')
end

def valid?(name)
  return false unless account_files(name).all?(&:exist?)
  return false unless crt = cert(name)
  return false unless active?(crt)
  return true if      ca?(crt)
  return false unless verified_by_ca?(crt, "#{WORK_DIR}/ca-#{get_ca_for(name)}.pem")
  return false unless subject_alt_names(crt).sort.uniq == CONFIG['accounts'][name]['hosts'].sort.uniq
  return false unless common_name(crt) == CONFIG['accounts'][name]['cn']
  true
end

def get_ca_for(name)
  "#{CONFIG['accounts'][name]['ca']}"
end

def account_files(name)
  %w(
    .pem
    .csr
    -key.pem
    -csr.json
  ).map { |ext| Pathname.new("#{WORK_DIR}/#{name}#{ext}") }
end

def gencsr(name, data = {})
  gencsr!(name, data) unless valid?(name)
end

def gencsr!(name, data)
  LOGGER.info "Generating #{name}-csr.json with algo #{CONFIG['csr']['key']['algo']} and size #{CONFIG['csr']['key']['size']}"
  names = CONFIG['names']['common'].merge(CONFIG['names'][name])
  content = CONFIG['csr'].merge(
    'hosts'   => data['hosts'],
    'CN'      => data['cn'],
    'names'   => [data['names']],
    'profile' => data.fetch('profile', name))
  LOGGER.debug "#{name}-csr.json: #{content.to_json}"
  write_file("#{name}-csr", content)
end

def write_file(file, content)
  file += '.json' if File.extname(file).empty?
  file = File.open("#{WORK_DIR}/#{file}", 'w')
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
  profile = CONFIG['accounts'][name].fetch('profile', name)
  gencmd = "cfssl gencert -ca=#{WORK_DIR}/ca-#{get_ca_for(name)}.pem" +
           " -ca-key=#{WORK_DIR}/ca-#{get_ca_for(name)}-key.pem" +
           " -config=#{WORK_DIR}/ca-config.json" +
           " -profile=#{profile}" +
           " #{WORK_DIR}/#{name}-csr.json" +
           "| cfssljson -bare #{WORK_DIR}/#{name}"
  LOGGER.info("... with #{gencmd}")
  system(gencmd)
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
  cert, key = ['.pem', '-key.pem'].map { |ext| File.read(pem_path(name, ext)) }

  hash = {
    'id' => "#{name}_ssl",
    'public_key' => cert,
    'private_key' => key
  }

  data_bag = Chef::DataBagItem.from_hash(hash)

  Chef::EncryptedDataBagItem.encrypt_data_bag_item(data_bag, secret)
end

desc 'Generate all the keys'
task default: CONFIG['ca'].map { |name| "ca:#{name}:generate" } + CONFIG['accounts'].map { |name, _data| "#{name}:generate" }

desc 'Generate all the keys and format encrypted databags'
task encrypt_all: CONFIG['ca'].map { |name| "ca:#{name}:encrypt" } + CONFIG['accounts'].map { |name, _data| "#{name}:encrypt" } do
  accounts = CONFIG['accounts'].map { |name, _data| name }.join(',')
  LOGGER.info "Now move #{WORK_DIR}/{#{CONFIG['ca'].map { |name| "ca-"+name}.join(',')},#{accounts}}_ssl.json to $chef_databags_folder/kubernetes"
end

namespace :ca do
  desc 'Certification authority configuration'
  task :config do
    filename = "#{WORK_DIR}/ca-config.json"
    next if File.exist?(filename)
    LOGGER.info "Generating ca-config.json with expiration period #{CONFIG['ca_config']['signing']['profiles']['ca']['expiry']}"
    ca_config = CONFIG['ca_config']
    LOGGER.debug "ca_config.json: #{ca_config.to_json}"
    write_file('ca-config', ca_config)
  end
end

CONFIG['ca'].each do |name|
  namespace "ca:#{name}" do
    desc 'Certification authority CSR'
    task :csr => "ca:config" do
      gencsr("ca-#{name}", {'cn' =>'Kubernetes', 'profile' => 'ca'})
    end

    desc 'Generate a CA certificate and private key'
    task :generate => :csr do
      cert_file = "#{WORK_DIR}/ca-#{name}.pem"
      key_file = "#{WORK_DIR}/ca-#{name}-key.pem"

      next if File.exist?(key_file) && File.exist?(cert_file)

      LOGGER.info "Initializing bare CA for #{name}"
      system("cfssl gencert -initca #{WORK_DIR}/ca-#{name}-csr.json | cfssljson -bare #{WORK_DIR}/ca-#{name}")
    end

    desc "Generate encrypted CA #{name} data bag"
    task :encrypt => :generate do
      LOGGER.info("Generating encrypted data bag for CA #{name}...")

      write_file(
        "ca-#{name}_ssl",
        encrypt("ca-#{name}", chef_secret(CHEF_SECRET_FILE))
      )
    end
  end
end

CONFIG['accounts'].each do |name, data|
  namespace name.to_sym do
    desc "Create the #{name} client certificate signing request"
    task :csr => "ca:#{get_ca_for(name)}:generate" do
      gencsr(name, data)
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
