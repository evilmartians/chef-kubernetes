#
# Cookbook Name:: kubernetes
# Recipe:: master
#
# Author:: Maxim Filatov <bregor@evilmartians.com>
#

include_recipe 'kubernetes::master_detect'
include_recipe "kubernetes::sdn_#{node['kubernetes']['sdn']}" if node['kubernetes']['use_sdn']
include_recipe 'firewall' if node['kubernetes']['enable_firewall']

directory "/opt/kubernetes/#{node['kubernetes']['version']}/bin" do
  recursive true
end

%w(apiserver controller-manager scheduler).each do |f|
  remote_file "/opt/kubernetes/#{node['kubernetes']['version']}/bin/kube-#{f}" do
    source "#{node['kubernetes']['packages']['storage_url']}kube-#{f}"
    mode '0755'
    checksum node['kubernetes']['checksums'][f]
    not_if do
      node['kubernetes']['install_via'] == 'static_pods'
    end
  end
end

%w(ssl addons).each do |dir|
  directory "/etc/kubernetes/#{dir}" do
    recursive true
  end
end

include_recipe 'kubernetes::kubeconfig'

# Encryption config
keys = data_bag_item(node['kubernetes']['databag'], 'encryption_keys')[node['kubernetes']['encryption']]

# TODO: Fix this style.
keys.map! do |k|
  {
    'name' => k['name'],
    'secret' => Base64.encode64(k['secret']),
  }
end
keys.sort_by! { |key| key['name'] }

template node['kubernetes']['api']['experimental_encryption_provider_config'] do
  source 'encryption-config.yaml.erb'
  variables(keys: keys)
end

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

node['kubernetes']['ssl']['keypairs'].each do |keypair|
  %w(public_key private_key).each do |key_type|
    file node['kubernetes']['ssl'][keypair][key_type] do
      content data_bag_item(
        node['kubernetes']['databag'],
        "#{keypair}_ssl"
      )[key_type]
    end
  end
end

template '/etc/kubernetes/authorization-policy.jsonl' do
  source 'authorization-policy.jsonl.erb'
  only_if do
    node['kubernetes']['authorization']['mode'].include?('ABAC')
  end
end

if node['kubernetes']['authorization']['mode'].include? 'RBAC'
  template '/etc/kubernetes/addons/apiserver-to-kubelet-clusterrole.yaml' do
    source 'apiserver-to-kubelet-clusterrole.yaml.erb'
  end

  %w(
    admin
    node-bootstrapper
    apiserver-to-kubelet
    kubelet-client-certificate-rotation
    kubelet-server-certificate-rotation
  ).each do |manifest|
    template "/etc/kubernetes/addons/#{manifest}-clusterrolebinding.yaml" do
      source "#{manifest}-clusterrolebinding.yaml.erb"
    end
  end
end

if node['kubernetes']['addons']['npd']['enabled']
  template('/etc/kubernetes/addons/npd.yaml') { source 'npd.yaml.erb' }
end

if node['kubernetes']['token_auth']
  template node['kubernetes']['token_auth_file'] do
    source 'tokens.csv.erb'
    variables(
      users: data_bag_item(
        node['kubernetes']['databag'],
        'users'
      )['users']
    )
  end
end

firewall_rule 'kube_apiserver' do
  port node['kubernetes']['api']['secure_port']
  protocol :tcp
  command :allow
  only_if do
    node['kubernetes']['enable_firewall']
  end
end

include_recipe "kubernetes::master_#{install_via}"
include_recipe 'kubernetes::haproxy' if node['kubernetes']['multimaster']['access_via'] == 'haproxy'
include_recipe 'kubernetes::proxy'
include_recipe 'kubernetes::cleaner'
