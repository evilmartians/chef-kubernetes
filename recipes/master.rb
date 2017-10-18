#
# Cookbook Name:: kubernetes
# Recipe:: master
#
# Author:: Maxim Filatov <bregor@evilmartians.com>
#

include_recipe 'kubernetes::master_detect'
include_recipe "kubernetes::sdn_#{node['kubernetes']['sdn']}" if node['kubernetes']['use_sdn']

directory "/opt/kubernetes/#{node['kubernetes']['version']}/bin" do
  recursive true
end

%w(apiserver controller-manager scheduler).each do |f|
  remote_file "/opt/kubernetes/#{node['kubernetes']['version']}/bin/kube-#{f}" do
    source "https://storage.googleapis.com/kubernetes-release/release/#{node['kubernetes']['version']}/bin/linux/amd64/kube-#{f}"
    mode '0755'
    not_if do
      begin
        Digest::MD5.file("/opt/kubernetes/#{node['kubernetes']['version']}/bin/kube-#{f}").to_s == node['kubernetes']['md5'][f.to_sym]
      rescue
        false
      end
    end
  end
end

%w(ssl addons).each do |dir|
  directory "/etc/kubernetes/#{dir}" do
    recursive true
  end
end

include_recipe 'kubernetes::kubeconfig'

# DNS manifests
manifests = %w(sa cm deploy svc)
unless node['kubernetes']['addons']['dns']['controller'] == 'kubedns'
  manifests += %w(clusterrole clusterrolebinding)
end

manifests.each do |manifest|
  template "/etc/kubernetes/addons/dns-#{manifest}.yaml" do
    source "#{node['kubernetes']['addons']['dns']['controller']}-#{manifest}.yaml.erb"
  end
end

%w(
  dashboard-deployment
  dashboard-svc
).each do |srv|
  template "/etc/kubernetes/addons/#{srv}.yaml" do
    source "#{srv}.yaml.erb"
  end
end

%w(apiserver ca).each do |keypair|
  %w(public_key private_key).each do |key_type|
    file node['kubernetes']['ssl'][keypair][key_type] do
      content Chef::EncryptedDataBagItem.load(node['kubernetes']['databag'], "#{keypair}_ssl")[key_type]
    end
  end
end

if node['kubernetes']['authorization']['mode'].include?('ABAC')
  template '/etc/kubernetes/authorization-policy.jsonl' do
    source 'authorization-policy.jsonl.erb'
  end
end

if node['kubernetes']['authorization']['mode'].include? 'RBAC'
  template '/etc/kubernetes/addons/admin-clusterrolebinding.yaml' do
    source 'admin-clusterrolebinding.yaml.erb'
  end
end

if node['kubernetes']['token_auth']
  template node['kubernetes']['token_auth_file'] do
    source 'tokens.csv.erb'
    variables(users: Chef::EncryptedDataBagItem.load(node['kubernetes']['databag'], 'users')['users'])
  end
end

include_recipe "kubernetes::master_#{install_via}"
include_recipe 'kubernetes::haproxy' if node['kubernetes']['multimaster']['access_via'] == 'haproxy'
include_recipe 'kubernetes::proxy'
include_recipe 'kubernetes::cleaner'
