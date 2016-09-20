#
# Cookbook Name:: kubernetes
# Recipe:: master
#
# Author:: Maxim Filatov <bregor@evilmartians.com>
#

include_recipe 'kubernetes::default'

['etcd', 'apiserver', 'controller-manager', 'scheduler', 'addon-manager'].each do |srv|
  template "/etc/kubernetes/manifests/#{srv}.yaml" do
    source "#{srv}.yaml.erb"
    variables(advertise_address: Chef::Recipe.allocate.internal_ip(node))
  end
end

['skydns-rc', 'skydns-svc', 'dashboard-deployment', 'dashboard-svc'].each do |srv|
  template "/etc/kubernetes/addons/#{srv}.yaml" do
    source "#{srv}.yaml.erb"
  end
end

if node[:kubernetes][:weave][:use_scope]
  template '/etc/kubernetes/addons/weavescope.yaml' do
    source 'weavescope.yaml.erb'
    variables(listen_addr: Chef::Recipe.allocate.internal_ip(node))
  end
end

['client_ca_file', 'tls_cert_file', 'tls_private_key_file'].each do |f|
  file node[:kubernetes][f.to_sym] do
    content Chef::EncryptedDataBagItem.load(node[:kubernetes][:databag], "#{node[:kubernetes][:cluster_name]}_cluster_ssl")[f]
  end
end

if node[:kubernetes][:authorization][:mode] == 'ABAC'
  template '/etc/kubernetes/authorization-policy.jsonl' do
    source 'authorization-policy.jsonl.erb'
  end
end

if node[:kubernetes][:token_auth]
  template node[:kubernetes][:token_auth_file] do
    source 'tokens.csv.erb'
    variables(users: Chef::EncryptedDataBagItem.load(node[:kubernetes][:databag], 'users')['users'])
  end
end
