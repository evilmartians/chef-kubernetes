#
# Cookbook Name:: kubernetes
# Recipe:: etcd
#
# Author:: Maxim Filatov <bregor@evilmartians.com>
#

nodes = search(:node, "roles:#{node['etcd']['role']}").map { |n| internal_ip(n) }.sort
initial_cluster_string = nodes.map { |addr| "#{addr}=#{node['etcd']['proto']}://#{addr}:#{node['etcd']['server_port']}" }.join ','
internal_ip = node['network']['interfaces'][node['kubernetes']['interface']]['addresses'].find { |address, data| data['family'] == 'inet' }.first

group node['etcd']['group'] do
  not_if { node['kubernetes']['install_via'] == 'static_pods' }
end

user node['etcd']['user'] do
  comment 'Etcd user'
  gid node['etcd']['group']
  shell '/bin/bash'
  not_if { node['kubernetes']['install_via'] == 'static_pods' }
end

etcd_user = node['etcd']['user']
etcd_group = node['etcd']['group']

case node['kubernetes']['install_via']
when 'static_pods'
  etcd_user = 'root'
  etcd_group = 'root'
end

[node['etcd']['data_dir'], "#{node['etcd']['data_dir']}/member", node['etcd']['wal_dir']].each do |d|
  directory d do
    recursive true
    owner etcd_user
    group etcd_group
  end
end

if install_via == 'static_pods'

  directory '/etc/kubernetes/manifests' do
    recursive true
  end

  template '/etc/kubernetes/manifests/etcd.yaml' do
    source 'etcd.yaml.erb'
    variables(initial_cluster: initial_cluster_string)
  end

end

unless install_via == 'static_pods'

  FileUtils.rm_f('/etc/kubernetes/manifests/etcd.yaml')

  service_type = install_via(node)

  etcd_service 'etcd' do
    action [:create, :start]
    node_name internal_ip
    install_method 'binary'
    service_manager service_type
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
    not_if { nodes.empty? || nodes.any?(&:empty?) }
  end

end
