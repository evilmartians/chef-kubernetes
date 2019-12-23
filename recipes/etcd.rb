#
# Cookbook Name:: kubernetes
# Recipe:: etcd
#
# Author:: Maxim Filatov <bregor@evilmartians.com>
#

etcd_nodes = search(
  :node,
  "roles:#{node['etcd']['role']}"
).map { |n| k8s_ip(n) }.sort

initial_cluster_string =
  etcd_nodes.map do |addr|
  "#{addr}=#{node['etcd']['proto']}://#{addr}:#{node['etcd']['server_port']}"
end.join ','

group node['etcd']['group'] do
  not_if { node['kubernetes']['install_via'] == 'static_pods' }
end

user node['etcd']['user'] do
  comment 'Etcd user'
  gid node['etcd']['group']
  shell '/bin/bash'
  not_if { node['kubernetes']['install_via'] == 'static_pods' }
end

if install_via == 'static_pods'
  etcd_user = 'root'
  etcd_group = 'root'
else
  etcd_user = node['etcd']['user']
  etcd_group = node['etcd']['group']
end

[
  node['etcd']['data_dir'],
  "#{node['etcd']['data_dir']}/member",
  node['etcd']['wal_dir']
].each do |d|
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
    not_if { etcd_nodes.empty? }
  end

else
  file '/etc/kubernetes/manifests/etcd.yaml' do
    action :delete
  end

  service_type = install_via(node)

  extra_unit = node['etcd']['default_service_name'] ? "etcd-#{k8s_ip}" : 'etcd'
  systemd_unit extra_unit do
    action [:disable, :stop, :delete]
  end

  %w(ca-etcd_server ca-etcd_peer etcd_server etcd_peer).each do |keypair|
    files = data_bag_item(node['kubernetes']['databag'], "#{keypair}_ssl")
    file "/etc/kubernetes/ssl/#{keypair}.pem" do
      content files['public_key']
    end
    file "/etc/kubernetes/ssl/#{keypair}-key.pem" do
      content files['private_key']
    end
  end

  etcd_service 'etcd' do
    action %i[create start]
    node_name k8s_ip
    default_service_name node['etcd']['default_service_name']
    install_method 'binary'
    service_manager service_type
    advertise_client_urls "#{node['etcd']['proto']}://#{k8s_ip}:#{node['etcd']['client_port']}"
    cert_file node['etcd']['cert_file']
    client_cert_auth node['etcd']['client_cert_auth']
    data_dir node['etcd']['data_dir']
    initial_advertise_peer_urls "#{node['etcd']['proto']}://#{k8s_ip}:#{node['etcd']['server_port']}"
    initial_cluster initial_cluster_string
    initial_cluster_state node['etcd']['initial_cluster_state']
    initial_cluster_token node['etcd']['initial_cluster_token']
    key_file node['etcd']['key_file']
    listen_client_urls "#{node['etcd']['proto']}://#{k8s_ip}:#{node['etcd']['client_port']},http://127.0.0.1:2379"
    listen_peer_urls "#{node['etcd']['proto']}://#{k8s_ip}:#{node['etcd']['server_port']},http://127.0.0.1:2380"
    peer_cert_file node['etcd']['peer_cert_file']
    peer_client_cert_auth node['etcd']['peer_client_cert_auth']
    peer_key_file node['etcd']['peer_key_file']
    peer_trusted_ca_file node['etcd']['peer_trusted_ca_file']
    trusted_ca_file node['etcd']['trusted_ca_file']
    wal_dir node['etcd']['wal_dir']
    version node['etcd']['version'].tr('A-z', '')
    checksum node['etcd']['checksum']
    not_if do
      etcd_nodes.empty? or etcd_nodes.any?(&:empty?)
    end
  end
end

firewall_rule 'etcd' do
  port [2379, 2380]
  protocol :tcp
  interface node['kubernetes']['interface']
  command :allow
  only_if do
    node['kubernetes']['enable_firewall']
  end
end
