#
# Cookbook Name:: kubernetes
# Recipe:: default
#
# Author:: Maxim Filatov <bregor@evilmartians.com>
#

require 'base64'

include_recipe 'kubernetes::packages'

master_nodes = search(:node, "role:#{node[:kubernetes][:roles][:master]}").map {|n| {name: hostname(n), ip: internal_ip(n)} }
master_url = case node[:kubernetes][:multimaster][:access_via]
             when 'haproxy'
               "https://#{node[:kubernetes][:multimaster][:haproxy_url]}:#{node[:kubernetes][:multimaster][:haproxy_port]}"
             when 'direct'
               "https://#{master_nodes.first[:ip]}:#{node[:kubernetes][:secure_port]}"
             when 'dns'
               "https://#{node[:kubernetes][:multimaster][:dns_name]}"
             end
node.set[:kubernetes][:master] = master_url

%w(manifests ssl addons).each do |dir|
  directory("/etc/kubernetes/#{dir}") do
    recursive true
  end
end

ca_file = Chef::EncryptedDataBagItem.load(node[:kubernetes][:databag], "#{node[:kubernetes][:cluster_name]}_cluster_ssl")['client_ca_file']

file node[:kubernetes][:client_ca_file] do
  content ca_file
end

include_recipe 'kubernetes::haproxy' if node[:kubernetes][:multimaster][:access_via] == 'haproxy'

template '/etc/kubernetes/kubeconfig-bootstrap.yaml' do
  source 'kubeconfig.yaml.erb'
  if node[:kubernetes][:token_auth]
    variables(token: Chef::EncryptedDataBagItem.load(node[:kubernetes][:databag], 'users')['users']
                .find { |user| user['name'] == 'kubelet-bootstrap' }['token'],
              ca_file: Base64.encode64(ca_file).gsub(/\n/,''),
              user: 'kubelet-bootstrap')
  end
end

template '/etc/kubernetes/kubeconfig.yaml' do
  source 'kubeconfig.yaml.erb'
  if node[:kubernetes][:token_auth]
    variables(token: Chef::EncryptedDataBagItem.load(node[:kubernetes][:databag], 'users')['users']
                .find { |user| user['name'] == 'kubelet' }['token'],
              ca_file: Base64.encode64(ca_file).gsub(/\n/,''),
              user: 'kubelet')
  end
end

template '/etc/kubernetes/manifests/proxy.yaml' do
  source 'proxy.yaml.erb'
end

link '/usr/local/bin/kubelet' do
  to "/opt/kubernetes/#{node[:kubernetes][:version]}/bin/kubelet"
  notifies :restart, 'poise_service[kubelet]'
end

# TODO: avoid Recipe.allocate in kubelet command
kubelet_args = [
  "--address=#{Chef::Recipe.allocate.internal_ip(node)}",
  "--api_servers=#{node[:kubernetes][:master]}",
  "--cluster-dns=#{node[:kubernetes][:cluster_dns]}",
  "--hostname_override=#{Chef::Recipe.allocate.hostname(node)}",
  "--node-ip=#{Chef::Recipe.allocate.internal_ip(node)}",
  '--allow_privileged=true',
  '--pod-manifest-path=/etc/kubernetes/manifests',
  '--node-status-update-frequency=4s',
  '--kubeconfig=/etc/kubernetes/kubeconfig.yaml',
  '--experimental-bootstrap-kubeconfig=/etc/kubernetes/kubeconfig-bootstrap.yaml',
  '--cert-dir=/etc/kubernetes/ssl',
  '--network-plugin=cni',
  '--network-plugin-dir=/etc/cni/net.d',
  "--image-gc-low-threshold=#{node[:kubernetes][:kubelet][:image_gc_low_threshold]}",
  "--image-gc-high-threshold=#{node[:kubernetes][:kubelet][:image_gc_high_threshold]}"
]

poise_service 'kubelet' do
  provider node['platform_version'].to_f < 16.04 ? :runit : :systemd
  command "/usr/local/bin/kubelet #{kubelet_args.join(' ')}"
end

poise_service_options 'kubelet' do
  restart_on_update true
end
