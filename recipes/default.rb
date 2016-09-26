#
# Cookbook Name:: kubernetes
# Recipe:: default
#
# Author:: Maxim Filatov <bregor@evilmartians.com>
#

include_recipe 'kubernetes::packages'

%w(manifests tokens ssl addons).each do |dir|
  directory("/etc/kubernetes/#{dir}") do
    recursive true
  end
end

file node[:kubernetes][:client_ca_file] do
  content Chef::EncryptedDataBagItem.load(node[:kubernetes][:databag], "#{node[:kubernetes][:cluster_name]}_cluster_ssl")['client_ca_file']
end

template '/etc/kubernetes/kubeconfig.yaml' do
  source 'kubeconfig.yaml.erb'
  if node[:kubernetes][:token_auth]
    variables(token: Chef::EncryptedDataBagItem.load(node[:kubernetes][:databag], 'users')['users']
               .find { |user| user['name'] == 'kubelet' }['token'])
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
  "--api_servers=https://#{node[:kubernetes][:master]}:#{node[:kubernetes][:api][:secure_port]}",
  "--cluster-dns=#{node[:kubernetes][:cluster_dns]}",
  "--hostname_override=#{Chef::Recipe.allocate.hostname(node)}",
  '--allow_privileged=true',
  '--config=/etc/kubernetes/manifests',
  '--node-status-update-frequency=4s',
  '--kubeconfig=/etc/kubernetes/kubeconfig.yaml',
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
