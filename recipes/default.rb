#
# Cookbook Name:: kubernetes
# Recipe:: default
#
# Author:: Maxim Filatov <bregor@evilmartians.com>
#

require 'base64'

include_recipe 'kubernetes::packages'
include_recipe 'kubernetes::master_detect'
include_recipe "kubernetes::sdn_#{node['kubernetes']['sdn']}" if node['kubernetes']['use_sdn']
include_recipe 'kubernetes::networking'
include_recipe 'kubernetes::haproxy' if node['kubernetes']['multimaster']['access_via'] == 'haproxy'
include_recipe 'firewall' if node['kubernetes']['enable_firewall']

%w(
  manifests
  ssl
  addons
).each do |dir|
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

template '/etc/kubernetes/kubeletconfig.yaml' do
  source 'kubeletconfig.yaml.erb'
  mode '0644'
  variables(
    address: k8s_ip(node), # FIXME
    options: kubelet_yaml(node['kubernetes']['kubelet']['config'])
  )
  case install_via
  when 'upstart'
    notifies :restart, 'service[kubelet]'
  when 'systemd'
    notifies :restart, 'systemd_unit[kubelet.service]'
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
    Unit: {
      Description: 'Systemd unit for Kubernetes worker service (kubelet)',
      After: "network.target remote-fs.target #{node['kubernetes']['container_engine']}.service",
    },
    Service: {
      Type: 'simple',
      ExecStart: "/usr/local/bin/kubelet #{kubelet_args.join(" \\\n")}",
      ExecReload: '/bin/kill -HUP $MAINPID',
      WorkingDirectory: '/',
      Restart: 'on-failure',
      RestartSec: '30s',
      LimitNOFILE: node['kubernetes']['limits']['nofile']['kubelet'],
    },
    Install: {
      WantedBy: 'multi-user.target',
    }
  )
  notifies :restart, 'systemd_unit[kubelet.service]'
  subscribes :restart, 'link[/usr/local/bin/kubelet]'
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
