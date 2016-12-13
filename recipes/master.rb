#
# Cookbook Name:: kubernetes
# Recipe:: master
#
# Author:: Maxim Filatov <bregor@evilmartians.com>
#

include_recipe 'kubernetes::master_detect'
include_recipe "kubernetes::sdn_#{node['kubernetes']['sdn']}" if node['kubernetes']['use_sdn']

etcd_nodes = search(:node, "role:etcd").map {|node| internal_ip(node)}
etcd_servers = etcd_nodes.map {|addr| "#{node['etcd']['proto']}://#{addr}:#{node['etcd']['client_port']}"}.join ','

master_nodes = search(:node, "role:#{node['kubernetes']['roles']['master']}")

['ssl', 'addons'].each do |dir|
  directory "/etc/kubernetes/#{dir}" do
    recursive true
  end
end

['apiserver', 'controller-manager', 'scheduler', 'addon-manager'].each do |srv|
  template "/etc/kubernetes/manifests/#{srv}.yaml" do
    source "#{srv}.yaml.erb"
    variables(etcd_servers: etcd_servers, apiserver_count: master_nodes.size)
  end
end

['skydns-deployment', 'skydns-svc', 'dashboard-deployment', 'dashboard-svc'].each do |srv|
  template "/etc/kubernetes/addons/#{srv}.yaml" do
    source "#{srv}.yaml.erb"
  end
end

%w(client_ca_file ca_key_file tls_cert_file tls_private_key_file).each do |f|
  file node['kubernetes'][f.to_sym] do
    content Chef::EncryptedDataBagItem.load(node['kubernetes']['databag'], "#{node['kubernetes']['cluster_name']}_cluster_ssl")[f]
  end
end

if node['kubernetes']['authorization']['mode'] == 'ABAC'
  template '/etc/kubernetes/authorization-policy.jsonl' do
    source 'authorization-policy.jsonl.erb'
  end
end

if node['kubernetes']['token_auth']
  template node['kubernetes']['token_auth_file'] do
    source 'tokens.csv.erb'
    variables(users: Chef::EncryptedDataBagItem.load(node['kubernetes']['databag'], 'users')['users'])
  end
end
