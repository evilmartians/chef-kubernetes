#
# Cookbook Name:: kubernetes
# Recipe:: default
#
# Author:: Maxim Filatov <bregor@evilmartians.com>
#

require 'base64'

include_recipe 'kubernetes::packages'
include_recipe 'kubernetes::master_detect'
include_recipe "kubernetes::sdn_#{node['kubernetes']['sdn']}"
include_recipe 'kubernetes::cleaner'
include_recipe 'kubernetes::haproxy' if node['kubernetes']['multimaster']['access_via'] == 'haproxy'

route node['kubernetes']['api']['service_cluster_ip_range'] do
  device node['kubernetes']['interface']
end

%w(manifests ssl addons).each do |dir|
  directory("/etc/kubernetes/#{dir}") do
    recursive true
  end
end

ca_file = Chef::EncryptedDataBagItem.load(node['kubernetes']['databag'], 'ca_ssl')['public_key']

file node['kubernetes']['client_ca_file'] do
  content ca_file
end

template '/etc/kubernetes/kubeconfig-bootstrap.yaml' do
  source 'kubeconfig.yaml.erb'
  if node['kubernetes']['token_auth']
    variables(token: Chef::EncryptedDataBagItem.load(node['kubernetes']['databag'], 'users')['users']
                .find { |user| user['name'] == 'kubelet-bootstrap' }['token'],
              ca_file: Base64.encode64(ca_file).delete("\n"),
              user: 'kubelet-bootstrap')
  end
end

include_recipe 'kubernetes::kubeconfig'
include_recipe 'kubernetes::proxy'

link '/usr/local/bin/kubelet' do
  to "/opt/kubernetes/#{node['kubernetes']['version']}/bin/kubelet"
  notifies :restart, 'systemd_service[kubelet]'
end

# TODO: avoid Recipe.allocate in kubelet command
kubelet_args = [
  "--address=#{Chef::Recipe.allocate.internal_ip(node)}",
  "--api_servers=#{node['kubernetes']['master']}",
  "--cluster-dns=#{node['kubernetes']['cluster_dns']}",
  "--hostname_override=#{Chef::Recipe.allocate.hostname(node)}",
  "--node-ip=#{Chef::Recipe.allocate.internal_ip(node)}",
  '--allow_privileged=true',
  "--register-node=#{node['kubernetes']['kubelet']['register_node']}",
  '--pod-manifest-path=/etc/kubernetes/manifests',
  '--node-status-update-frequency=4s',
  '--kubeconfig=/etc/kubernetes/kubeconfig.yaml',
  '--experimental-bootstrap-kubeconfig=/etc/kubernetes/kubeconfig-bootstrap.yaml',
  '--cert-dir=/etc/kubernetes/ssl',
  '--network-plugin=cni',
  '--network-plugin-dir=/etc/cni/net.d',
  "--image-gc-low-threshold=#{node['kubernetes']['kubelet']['image_gc_low_threshold']}",
  "--image-gc-high-threshold=#{node['kubernetes']['kubelet']['image_gc_high_threshold']}",
  "--cadvisor-port=#{node['kubernetes']['kubelet']['cadvisor_port']}",
  "--v=#{node['kubernetes']['kubelet']['verbosity']}"
]

if node['kubernetes']['kubelet']['system_reserved']
  res = node['kubernetes']['kubelet']['system_reserved']
  res = res.map { |hash| hash.map { |k, v| "#{k}=#{v}" }}.join(',')
  kubelet_args << "--system-reserved=#{res}"
end

template '/etc/init/kubelet.conf' do
  source 'upstart.conf.erb'
  owner 'root'
  group 'root'
  mode '0644'
  variables(
    service_description: 'Kubebernetes workload daemon',
    cmd: "/usr/local/bin/kubelet #{kubelet_args.join(' ')}"
  )
  only_if { node['platform_version'] == '14.04' }
end

service 'kubelet' do
  action [:start, :enable]
  provider Chef::Provider::Service::Upstart
  subscribes :restart, 'template[/etc/init/kubelet.conf]'
  only_if { node['platform_version'] == '14.04' }
end

systemd_service 'kubelet' do
  description 'Systemd unit for Kubernetes worker service (kubelet)'
  action [:create, :enable, :start]
  after %w(network.target remote-fs.target)
  install do
    wanted_by 'multi-user.target'
  end
  service do
    type 'simple'
    user 'root'
    exec_start "/usr/local/bin/kubelet #{kubelet_args.join(" \\\n")}"
    exec_reload '/bin/kill -HUP $MAINPID'
    working_directory '/'
    restart 'on-failure'
    restart_sec '30s'
  end
  not_if { node['platform_version'] == '14.04' }
end
