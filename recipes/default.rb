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
include_recipe 'kubernetes::networking'
include_recipe 'kubernetes::haproxy' if node['kubernetes']['multimaster']['access_via'] == 'haproxy'
include_recipe 'firewall'

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
end

kubelet_args = [
  "--address=#{internal_ip(node)}",
  "--api_servers=#{node['kubernetes']['master']}",
  "--cluster-dns=#{node['kubernetes']['cluster_dns']}",
  "--hostname_override=#{hostname(node)}",
  "--node-ip=#{internal_ip(node)}",
  '--allow_privileged=true',
  "--register-node=#{node['kubernetes']['kubelet']['register_node']}",
  '--pod-manifest-path=/etc/kubernetes/manifests',
  '--node-status-update-frequency=4s',
  '--kubeconfig=/etc/kubernetes/kubelet_config.yaml',
  '--experimental-bootstrap-kubeconfig=/etc/kubernetes/kubeconfig-bootstrap.yaml',
  '--cert-dir=/etc/kubernetes/ssl',
  '--network-plugin=cni',
  '--network-plugin-dir=/etc/cni/net.d',
  '--cni-bin-dir=/opt/cni/bin',
  '--cni-conf-dir=/etc/cni/net.d',
  "--cluster-domain=#{node['kubernetes']['cluster_domain']}",
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
  only_if { node['init_package'] == 'init' and node['packages'].has_key?('upstart') }
end

service 'kubelet' do
  action [:start, :enable]
  provider Chef::Provider::Service::Upstart
  subscribes :restart, 'template[/etc/init/kubelet.conf]'
  subscribes :restart, 'link[/usr/local/bin/kubelet]'
  only_if { node['init_package'] == 'init' and node['packages'].has_key?('upstart') }
end

systemd_service 'kubelet' do
  unit do
    description 'Systemd unit for Kubernetes worker service (kubelet)'
    action [:create, :enable, :start]
    after %w(network.target remote-fs.target)
  end
  install do
    wanted_by 'multi-user.target'
  end
  service do
    type 'simple'
    exec_start "/usr/local/bin/kubelet #{kubelet_args.join(" \\\n")}"
    exec_reload '/bin/kill -HUP $MAINPID'
    working_directory '/'
    restart 'on-failure'
    restart_sec '30s'
  end
  only_if { node['init_package'] == 'systemd' }
  subscribes :restart, 'link[/usr/local/bin/kubelet]'
end

firewall_rule 'kubelet' do
  port [10250, 10255]
  protocol :tcp
  interface node['kubernetes']['interface']
  command :allow
end

include_recipe 'kubernetes::cleaner'
