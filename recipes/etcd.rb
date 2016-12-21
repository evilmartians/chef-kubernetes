#
# Cookbook Name:: kubernetes
# Recipe:: etcd
#
# Author:: Maxim Filatov <bregor@evilmartians.com>
#

nodes = search(:node, 'role:etcd').map { |node| internal_ip(node) }
initial_cluster_string = nodes.map { |addr| "#{addr}=#{node['etcd']['proto']}://#{addr}:#{node['etcd']['server_port']}" }.join ','
internal_ip = node['network']['interfaces'][node['kubernetes']['interface']]['addresses'].find { |address, data| data['family'] == 'inet' }.first

%w(data wal).each do |t|
  directory node['etcd']["#{t}_dir"] do
    recursive true
    not_if { File.exist?(node['etcd']["#{t}_dir"]) }
  end
end

if node['kubernetes']['install_via'] == 'static_pods'

  directory '/etc/kubernetes/manifests' do
    recursive true
  end

  systemd_service "etcd-#{internal_ip}" do
    action [:disable, :stop]
    only_if { node['init_package'] == 'systemd' }
  end

  unless Etc.getpwuid(File.stat(node['etcd']['data_dir']).uid).name == 'root'
    FileUtils.chown_R('root', 'root', node['etcd']['data_dir'])
  end

  unless Etc.getpwuid(File.stat(node['etcd']['wal_dir']).uid).name == 'root'
    FileUtils.chown_R('root', 'root', node['etcd']['wal_dir'])
  end

  template '/etc/kubernetes/manifests/etcd.yaml' do
    source 'etcd.yaml.erb'
    variables(initial_cluster: initial_cluster_string)
  end

end

if node['kubernetes']['install_via'] == 'systemd_units'

  FileUtils.rm_f('/etc/kubernetes/manifests/etcd.yaml')

  unless Etc.getpwuid(File.stat(node['etcd']['data_dir']).uid).name == 'etcd'
    FileUtils.chown_R(node['etcd']['user'], node['etcd']['group'], node['etcd']['data_dir'])
  end

  unless Etc.getpwuid(File.stat(node['etcd']['wal_dir']).uid).name == 'etcd'
    FileUtils.chown_R(node['etcd']['user'], node['etcd']['group'], node['etcd']['wal_dir'])
  end

  etcd_service 'etcd' do
    action [:create, :start]
    node_name internal_ip
    install_method 'binary'
    service_manager 'systemd'
    data_dir node['etcd']['data_dir']
    wal_dir node['etcd']['wal_dir']
    initial_advertise_peer_urls "#{node['etcd']['proto']}://#{internal_ip}:#{node['etcd']['server_port']}"
    listen_peer_urls "#{node['etcd']['proto']}://#{internal_ip}:#{node['etcd']['server_port']},http://127.0.0.1:2380"
    listen_client_urls "#{node['etcd']['proto']}://#{internal_ip}:#{node['etcd']['client_port']},http://127.0.0.1:2379"
    advertise_client_urls "#{node['etcd']['proto']}://#{internal_ip}:#{node['etcd']['client_port']}"
    initial_cluster_token node['etcd']['initial_cluster_token']
    initial_cluster initial_cluster_string
    initial_cluster_state node['etcd']['initial_cluster_state']
    version node['etcd']['version'].tr('A-z', '')
  end

end
