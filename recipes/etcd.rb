#
# Cookbook Name:: kubernetes
# Recipe:: etcd
#
# Author:: Maxim Filatov <bregor@evilmartians.com>
#

nodes = search(:node, 'role:etcd').map {|node| internal_ip(node)}

initial_cluster_string = nodes.map {|addr| "#{addr}=#{node['etcd']['proto']}://#{addr}:#{node['etcd']['server_port']}"}.join ','

internal_ip = node['network']['interfaces'][node['kubernetes']['interface']]['addresses'].find { |address, data| data['family'] == 'inet' }.first

etcd_service 'etcd' do
  action [:create, :start]
  node_name internal_ip
  install_method 'binary'
  service_manager 'systemd'
  data_dir node['etcd']['data_dir']
  initial_advertise_peer_urls "#{node['etcd']['proto']}://#{internal_ip}:#{node['etcd']['server_port']}"
  listen_peer_urls "#{node['etcd']['proto']}://#{internal_ip}:#{node['etcd']['server_port']},http://127.0.0.1:2380"
  listen_client_urls "#{node['etcd']['proto']}://#{internal_ip}:#{node['etcd']['client_port']},http://127.0.0.1:2379"
  advertise_client_urls "#{node['etcd']['proto']}://#{internal_ip}:#{node['etcd']['client_port']}"
  initial_cluster_token node['etcd']['initial_cluster_token']
  initial_cluster initial_cluster_string
  initial_cluster_state node['etcd']['initial_cluster_state']
  # version node['etcd']['version'] # TODO: strip of 'v'
  version '2.3.7'
end
