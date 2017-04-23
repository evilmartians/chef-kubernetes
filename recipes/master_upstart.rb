#
# Cookbook Name:: kubernetes
# Recipe:: master_upstart
#
# Author:: Kirill Kuznetsov <kir@evilmartians.com>
#

etcd_nodes = search(:node, 'role:etcd').map { |node| internal_ip(node) }
etcd_servers = etcd_nodes.map { |addr| "#{node['etcd']['proto']}://#{addr}:#{node['etcd']['client_port']}" }.join ','

master_nodes = search(:node, "role:#{node['kubernetes']['roles']['master']}")

apiserver_args = [
  "--bind-address=#{node['kubernetes']['api']['bind_address']}",
  "--advertise-address=#{Chef::Recipe.allocate.internal_ip(node)}",
  "--etcd-servers=#{etcd_servers}",
  "--etcd-certfile=#{node['etcd']['cert_file']}",
  "--etcd-keyfile=#{node['etcd']['key_file']}",
  "--etcd-cafile=#{node['etcd']['trusted_ca_file']}",
  '--allow-privileged=true',
  "--apiserver-count=#{master_nodes.size}",
  "--service-cluster-ip-range=#{node['kubernetes']['api']['service_cluster_ip_range']}",
  "--secure-port=#{node['kubernetes']['api']['secure_port']}",
  "--insecure-bind-address=#{node['kubernetes']['api']['insecure_bind_address']}",
  "--insecure-port=#{node['kubernetes']['api']['insecure_port']}",
  "--admission-control=#{node['kubernetes']['api']['admission_control'].join(',')}",
  "--runtime-config=#{node['kubernetes']['api']['runtime_config'].join(',')}",
  "--tls-cert-file=#{node['kubernetes']['tls_cert_file']}",
  "--tls-private-key-file=#{node['kubernetes']['tls_private_key_file']}",
  "--client-ca-file=#{node['kubernetes']['client_ca_file']}",
  "--service-account-key-file=#{node['kubernetes']['service_account_key_file']}",
  "--cloud-config=#{node['kubernetes']['cloud_config']}",
  "--cloud-provider=#{node['kubernetes']['cloud_provider']}",
  '--log-dir=/var/log/kubernetes',
  "--authorization-mode=#{node['kubernetes']['authorization']['mode']}"
]

if node['kubernetes']['token_auth']
  apiserver_args.push "--token-auth-file=#{node['kubernetes']['token_auth_file']}"
end

if node['kubernetes']['authorization']['mode'].include? 'ABAC'
  apiserver_args.push '--authorization-policy-file=/etc/kubernetes/authorization-policy.jsonl'
end

if node['kubernetes']['audit']['enabled']
  apiserver_args.push "--audit-log-maxbackup=#{node['kubernetes']['audit']['maxbackup']}"
  apiserver_args.push "--audit-log-path=#{node['kubernetes']['audit']['log_file']}"
end

template '/etc/init/kube-apiserver.conf' do
  source 'upstart.conf.erb'
  owner 'root'
  group 'root'
  mode '0644'
  variables(
    service_description: 'Kubernetes API server',
    cmd: "/usr/local/bin/kube-apiserver #{apiserver_args.join(' ')}"
  )
end

service 'kube-apiserver' do
  action [:start, :enable]
  provider Chef::Provider::Service::Upstart
  subscribes :restart, 'link[/usr/local/bin/kube-apiserver]'
end

controller_manager_args = [
  '--address=127.0.0.1',
  '--leader-elect=true',
  "--cloud-config=#{node['kubernetes']['cloud_config']}",
  "--cloud-provider=#{node['kubernetes']['cloud_provider']}",
  "--cluster-cidr=#{node['kubernetes']['api']['service_cluster_ip_range']}",
  "--cluster-name=#{node['kubernetes']['cluster_name']}",
  "--service-account-private-key-file=#{node['kubernetes']['service_account_key_file']}",
  "--cluster-signing-cert-file=#{node['kubernetes']['cluster_signing_cert_file']}",
  "--cluster-signing-key-file=#{node['kubernetes']['cluster_signing_key_file']}",
  "--root-ca-file=#{node['kubernetes']['client_ca_file']}",
  "--master=http://127.0.0.1:#{node['kubernetes']['api']['insecure_port']}",
  '--node-monitor-period=2s',
  '--node-monitor-grace-period=16s',
  '--pod-eviction-timeout=30s'
]

template '/etc/init/kube-controller-manager.conf' do
  source 'upstart.conf.erb'
  owner 'root'
  group 'root'
  mode '0644'
  variables(
    service_description: 'Kubernetes Controller Manager',
    cmd: "/usr/local/bin/kube-controller-manager #{controller_manager_args.join(' ')}"
  )
end

service 'kube-controller-manager' do
  action [:start, :enable]
  provider Chef::Provider::Service::Upstart
  subscribes :restart, 'link[/usr/local/bin/kube-controller-manager]'
end

scheduler_args = [
  '--address=127.0.0.1',
  '--leader-elect=true',
  "--master=http://127.0.0.1:#{node['kubernetes']['api']['insecure_port']}"
]

template '/etc/init/kube-scheduler.conf' do
  source 'upstart.conf.erb'
  owner 'root'
  group 'root'
  mode '0644'
  variables(
    service_description: 'Kubernetes Controller Manager',
    cmd: "/usr/local/bin/kube-scheduler #{scheduler_args.join(' ')}"
  )
end

service 'kube-scheduler' do
  action [:start, :enable]
  provider Chef::Provider::Service::Upstart
  subscribes :restart, 'link[/usr/local/bin/kube-scheduler]'
end

template '/etc/kubernetes/kube-system-ns.yaml' do
  source 'kube-system-ns.yaml.erb'
  mode '0644'
end

template '/usr/local/bin/kube-addon-manager' do
  source 'kube-addon-manager.sh.erb'
  owner 'root'
  group 'root'
  mode '0755'
end

template '/etc/init/kube-addon-manager.conf' do
  source 'upstart.conf.erb'
  owner 'root'
  group 'root'
  mode '0644'
  variables(
    service_description: 'Kubernetes Addon Manager',
    cmd: "/usr/local/bin/kube-addon-manager"
  )
end

service 'kube-addon-manager' do
  action [:start, :enable]
  provider Chef::Provider::Service::Upstart
  subscribes :restart, 'template[/usr/local/bin/kube-addon-manager]'
  subscribes :restart, 'template[/etc/init/kube-addon-manager.conf]'
end

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
  link "/usr/local/bin/kube-#{f}" do
    to "/opt/kubernetes/#{node['kubernetes']['version']}/bin/kube-#{f}"
    notifies :restart, "systemd_service[kube-#{f}]"
  end
end
