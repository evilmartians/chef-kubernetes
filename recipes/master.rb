#
# Cookbook Name:: kubernetes
# Recipe:: master
#
# Author:: Maxim Filatov <bregor@evilmartians.com>
#

include_recipe 'kubernetes::default'

etcd_nodes = search(:node, "role:etcd").map {|node| internal_ip(node)}
etcd_servers = etcd_nodes.map {|addr| "#{node[:etcd][:proto]}://#{addr}:#{node[:etcd][:client_port]}"}.join ','

template '/etc/kubernetes/manifests/apiserver.yaml' do
  source 'apiserver.yaml.erb'
  variables(etcd_servers: etcd_servers)
end

['controller-manager', 'scheduler', 'addon-manager'].each do |srv|
  template "/etc/kubernetes/manifests/#{srv}.yaml" do
    source "#{srv}.yaml.erb"
  end
end

['weave-kube-daemonset', 'skydns-rc', 'skydns-svc', 'dashboard-deployment', 'dashboard-svc'].each do |srv|
  template "/etc/kubernetes/addons/#{srv}.yaml" do
    source "#{srv}.yaml.erb"
  end
end

if node[:kubernetes][:weave][:use_scope]
  ['weavescope-deployment', 'weavescope-svc', 'weavescope-daemonset']. each do |srv|
    template "/etc/kubernetes/addons/#{srv}.yaml" do
      source "#{srv}.yaml.erb"
    end
  end
end

%w(client_ca_file tls_cert_file tls_private_key_file).each do |f|
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
