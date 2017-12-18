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
include_recipe 'firewall' if node['kubernetes']['enable_firewall']

%w(manifests ssl addons).each do |dir|
  directory("/etc/kubernetes/#{dir}") do
    recursive true
  end
end

ca_file = data_bag_item(node['kubernetes']['databag'], 'ca_ssl')['public_key']

file node['kubernetes']['client_ca_file'] do
  content ca_file
end

users_data = data_bag_item(node['kubernetes']['databag'], 'users')['users']
token = users_data.find { |user| user['name'] == 'kubelet-bootstrap' }['token']

template '/etc/kubernetes/kubeconfig-bootstrap.yaml' do
  source 'kubeconfig.yaml.erb'
  if node['kubernetes']['token_auth']

    users_data = data_bag_item(node['kubernetes']['databag'], 'users')['users']
    token = users_data.find { |user| user['name'] == 'kubelet-bootstrap' }['token']

    variables(
      token: token,
      ca_file: Base64.encode64(ca_file).delete("\n"),
      user: 'kubelet-bootstrap'
    )
  end
end

include_recipe 'kubernetes::kubeconfig'
include_recipe 'kubernetes::proxy'

link '/usr/local/bin/kubelet' do
  to "/opt/kubernetes/#{node['kubernetes']['version']}/bin/kubelet"
end

kubelet_args = [
  "--address=#{k8s_ip(node)}",
  "--cluster-dns=#{node['kubernetes']['cluster_dns']}",
  "--hostname_override=#{k8s_hostname(node)}",
  "--node-ip=#{k8s_ip(node)}",
  '--allow_privileged=true',
  "--anonymous-auth=#{node['kubernetes']['kubelet']['anonymous_auth']}",
  "--authorization-mode=#{node['kubernetes']['kubelet']['authorization_mode']}",
  '--authentication-token-webhook',
  "--client-ca-file=#{node['kubernetes']['kubelet']['client_ca_file']}",
  "--register-node=#{node['kubernetes']['kubelet']['register_node']}",
  '--pod-manifest-path=/etc/kubernetes/manifests',
  '--node-status-update-frequency=4s',
  '--kubeconfig=/etc/kubernetes/kubelet.yaml',
  '--bootstrap-kubeconfig=/etc/kubernetes/kubeconfig-bootstrap.yaml',
  "--feature-gates=#{node['kubernetes']['feature_gates'].join(',')}",
  '--cert-dir=/etc/kubernetes/ssl',
  '--network-plugin=cni',
  '--cni-bin-dir=/opt/cni/bin',
  '--cni-conf-dir=/etc/cni/net.d',
  "--fail-swap-on=#{node['kubernetes']['kubelet']['fail_swap_on']}",
  "--cluster-domain=#{node['kubernetes']['cluster_domain']}",
  "--image-gc-low-threshold=#{node['kubernetes']['kubelet']['image_gc_low_threshold']}",
  "--image-gc-high-threshold=#{node['kubernetes']['kubelet']['image_gc_high_threshold']}",
  "--cadvisor-port=#{node['kubernetes']['kubelet']['cadvisor_port']}",
  "--v=#{node['kubernetes']['kubelet']['verbosity']}"
]

if node['kubernetes']['kubelet']['system_reserved']
  res = node['kubernetes']['kubelet']['system_reserved']
  res = res.map { |hash| hash.map { |k, v| "#{k}=#{v}" } }.join(',')
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
  only_if do
    node['init_package'] == 'init' and node['packages'].key?('upstart')
  end
end

service 'kubelet' do
  action [:start, :enable]
  provider Chef::Provider::Service::Upstart
  subscribes :restart, 'template[/etc/init/kubelet.conf]'
  subscribes :restart, 'link[/usr/local/bin/kubelet]'
  only_if do
    node['init_package'] == 'init' and node['packages'].key?('upstart')
  end
end

systemd_unit 'kubelet.service' do
  content(
    'Unit' => {
      'Description' => 'Systemd unit for Kubernetes worker service (kubelet)',
      'After' => "network.target remote-fs.target #{node['kubernetes']['container_engine']}.service"
    },
    'Service' => {
      'Type' => 'simple',
      'ExecStart' => "/usr/local/bin/kubelet #{kubelet_args.join(" \\\n")}",
      'ExecReload' => '/bin/kill -HUP $MAINPID',
      'WorkingDirectory' => '/',
      'Restart' => 'on-failure',
      'RestartSec' => '30s'
    },
    'Install' => {
      'WantedBy' => 'multi-user.target'
    }
  )
  notifies :restart, 'systemd_unit[kubelet.service]'
  subscribes :restart, "remote_file[/opt/kubernetes/#{node['kubernetes']['version']}/bin/kubelet"
  action [:create, :enable, :start]
end

firewall_rule 'kubelet' do
  port [10_250, 10_255]
  protocol :tcp
  interface node['kubernetes']['interface']
  command :allow
  only_if do
    node['kubernetes']['enable_firewall']
  end
end

include_recipe 'kubernetes::cleaner'
