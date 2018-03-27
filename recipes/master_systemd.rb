#
# Cookbook Name:: kubernetes
# Recipe:: master_systemd
#
# Author:: Maxim Filatov <bregor@evilmartians.com>
#

%w(apiserver controller-manager scheduler).each do |f|
  link "/usr/local/bin/kube-#{f}" do
    to "/opt/kubernetes/#{node['kubernetes']['version']}/bin/kube-#{f}"
    notifies :restart, "systemd_unit[kube-#{f}.service]"
  end
end

etcd_nodes = search(
  :node,
  "roles:#{node['etcd']['role']}"
).map { |node| k8s_ip(node) }

etcd_servers = etcd_nodes.map do |addr|
  "#{node['etcd']['proto']}://#{addr}:#{node['etcd']['client_port']}"
end.join ','

if etcd_nodes.empty?
  etcd_servers = "#{node['etcd']['proto']}://#{k8s_ip(node)}:#{node['etcd']['client_port']}"
end

apiserver_args = [
  "--bind-address=#{node['kubernetes']['api']['bind_address']}",
  "--advertise-address=#{k8s_ip(node)}",
  "--etcd-servers=#{etcd_servers}",
  "--etcd-certfile=#{node['etcd']['cert_file']}",
  "--etcd-keyfile=#{node['etcd']['key_file']}",
  "--etcd-cafile=#{node['etcd']['trusted_ca_file']}",
  "--storage-backend=#{node['kubernetes']['api']['storage_backend']}",
  "--storage-media-type=#{node['kubernetes']['api']['storage_media_type']}",
  '--allow-privileged=true',
  "--service-cluster-ip-range=#{node['kubernetes']['api']['service_cluster_ip_range']}",
  "--secure-port=#{node['kubernetes']['api']['secure_port']}",
  "--insecure-bind-address=#{node['kubernetes']['api']['insecure_bind_address']}",
  "--insecure-port=#{node['kubernetes']['api']['insecure_port']}",
  "--enable-admission-plugins=#{node['kubernetes']['api']['enabled_admission_plugins'].join(',')}",
  "--disable-admission-plugins=#{node['kubernetes']['api']['disabled_admission_plugins'].join(',')}",
  "--runtime-config=#{node['kubernetes']['api']['runtime_config'].join(',')}",
  "--tls-cert-file=#{node['kubernetes']['tls_cert_file']}",
  "--tls-private-key-file=#{node['kubernetes']['tls_private_key_file']}",
  "--client-ca-file=#{node['kubernetes']['client_ca_file']}",
  "--service-account-key-file=#{node['kubernetes']['service_account_key_file']}",
  "--kubelet-https=#{node['kubernetes']['api']['kubelet_https']}",
  "--kubelet-certificate-authority=#{node['kubernetes']['api']['kubelet_certificate_authority']}",
  "--kubelet-client-certificate=#{node['kubernetes']['api']['kubelet_client_certificate']}",
  "--kubelet-client-key=#{node['kubernetes']['api']['kubelet_client_key']}",
  "--cloud-config=#{node['kubernetes']['cloud_config']}",
  "--cloud-provider=#{node['kubernetes']['cloud_provider']}",
  '--log-dir=/var/log/kubernetes',
  "--authorization-mode=#{node['kubernetes']['authorization']['mode']}",
  "--experimental-encryption-provider-config=#{node['kubernetes']['api']['experimental_encryption_provider_config']}",
  "--feature-gates=#{node['kubernetes']['feature_gates'].join(',')}",
  '--enable-bootstrap-token-auth',
  "--endpoint-reconciler-type=#{node['kubernetes']['api']['endpoint_reconciler_type']}"
]

if node['kubernetes']['api']['endpoint_reconciler_type'] == 'master-count'
  master_nodes = search(:node, "roles:#{node['kubernetes']['roles']['master']}")
  master_nodes = [node] if master_nodes.empty?
  apiserver_args.push "--apiserver-count=#{master_nodes.size}"
end

if node['kubernetes']['token_auth']
  apiserver_args.push "--token-auth-file=#{node['kubernetes']['token_auth_file']}"
end

if node['kubernetes']['authorization']['mode'].include?('ABAC')
  apiserver_args.push '--authorization-policy-file=/etc/kubernetes/authorization-policy.jsonl'
end

if node['kubernetes']['audit']['enabled']
  apiserver_args.push "--audit-log-maxbackup=#{node['kubernetes']['audit']['maxbackup']}"
  apiserver_args.push "--audit-log-path=#{node['kubernetes']['audit']['log_file']}"
end

systemd_unit 'kube-apiserver.service' do
  content(
    Unit: {
      Description: 'Systemd unit for Kubernetes API server',
      After: 'network.target remote-fs.target'
    },
    Service: {
      Type: 'simple',
      ExecStart: "/usr/local/bin/kube-apiserver #{apiserver_args.join(" \\\n")}",
      ExecReload: '/bin/kill -HUP $MAINPID',
      WorkingDirectory: '/',
      Restart: 'on-failure',
      RestartSec: '30s'
    },
    Install: {
      WantedBy: 'multi-user.target'
    }
  )
  notifies :restart, 'systemd_unit[kube-apiserver.service]'
  action [:create, :enable, :start]
end

controller_manager_args = [
  '--address=127.0.0.1',
  '--leader-elect=true',
  "--cloud-config=#{node['kubernetes']['cloud_config']}",
  "--cloud-provider=#{node['kubernetes']['cloud_provider']}",
  "--cluster-cidr=#{node['kubernetes']['cluster_cidr']}",
  "--cluster-name=#{node['kubernetes']['cluster_name']}",
  "--service-account-private-key-file=#{node['kubernetes']['service_account_key_file']}",
  "--cluster-signing-cert-file=#{node['kubernetes']['cluster_signing_cert_file']}",
  "--cluster-signing-key-file=#{node['kubernetes']['cluster_signing_key_file']}",
  "--root-ca-file=#{node['kubernetes']['client_ca_file']}",
  "--master=http://127.0.0.1:#{node['kubernetes']['api']['insecure_port']}",
  "--feature-gates=#{node['kubernetes']['feature_gates'].join(',')}",
  '--node-monitor-period=2s',
  '--node-monitor-grace-period=16s',
  '--pod-eviction-timeout=30s'
]

if node['kubernetes']['sdn'] == 'canal'
  controller_manager_args.push '--allocate-node-cidrs'
  controller_manager_args.push "--node-cidr-mask-size=#{node['kubernetes']['node_cidr_mask_size']}"
end

systemd_unit 'kube-controller-manager.service' do
  content(
    Unit: {
      Description: 'Systemd unit for Kubernetes Controller Manager',
      After: 'network.target remote-fs.target kube-apiserver.service'
    },
    Service: {
      Type: 'simple',
      ExecStart: "/usr/local/bin/kube-controller-manager #{controller_manager_args.join(" \\\n")}",
      ExecReload: '/bin/kill -HUP $MAINPID',
      WorkingDirectory: '/',
      Restart: 'on-failure',
      RestartSec: '30s'
    },
    Install: {
      WantedBy: 'multi-user.target'
    }
  )
  notifies :restart, 'systemd_unit[kube-controller-manager.service]'
  action [:create, :enable, :start]
end

scheduler_args = [
  '--address=127.0.0.1',
  '--leader-elect=true',
  "--feature-gates=#{node['kubernetes']['feature_gates'].join(',')}",
  "--master=http://127.0.0.1:#{node['kubernetes']['api']['insecure_port']}"
]

systemd_unit 'kube-scheduler.service' do
  content(
    Unit: {
      Description: 'Systemd unit for Kubernetes Scheduler',
      After: 'network.target remote-fs.target kube-apiserver.service'
    },
    Service: {
      Type: 'simple',
      ExecStart: "/usr/local/bin/kube-scheduler #{scheduler_args.join(" \\\n")}",
      ExecReload: '/bin/kill -HUP $MAINPID',
      WorkingDirectory: '/',
      Restart: 'on-failure',
      RestartSec: '30s'
    },
    Install: {
      WantedBy: 'multi-user.target'
    }
  )
  notifies :restart, 'systemd_unit[kube-scheduler.service]'
  action [:create, :enable, :start]
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

systemd_unit 'kube-addon-manager.service' do
  content(
    Unit: {
      Description: 'Systemd unit for Kubernetes Addon Manager',
      After: 'network.target remote-fs.target kube-apiserver.service'
    },
    Service: {
      Type: 'simple',
      ExecStart: '/usr/local/bin/kube-addon-manager',
      ExecReload: '/bin/kill -HUP $MAINPID',
      WorkingDirectory: '/',
      Restart: 'on-failure',
      RestartSec: '30s'
    },
    Install: {
      WantedBy: 'multi-user.target'
    }
  )
  notifies :restart, 'systemd_unit[kube-addon-manager.service]'
  subscribes :restart, 'template[/usr/local/bin/kube-addon-manager]'
  action [:create, :enable, :start]
end
