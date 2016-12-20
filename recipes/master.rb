#
# Cookbook Name:: kubernetes
# Recipe:: master
#
# Author:: Maxim Filatov <bregor@evilmartians.com>
#

include_recipe 'kubernetes::master_detect'
include_recipe "kubernetes::sdn_#{node['kubernetes']['sdn']}" if node['kubernetes']['use_sdn']

['ssl', 'addons'].each do |dir|
  directory "/etc/kubernetes/#{dir}" do
    recursive true
  end
end

template "/etc/kubernetes/manifests/addon-manager.yaml" do
  source "addon-manager.yaml.erb"
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

include_recipe "kubernetes::master_#{node['kubernetes']['install_via']}"
