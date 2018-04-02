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
      RestartSec: '30s',
      LimitNOFILE: node['kubernetes']['limits']['nofile']['apiserver']
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
      RestartSec: '30s',
      LimitNOFILE: node['kubernetes']['limits']['nofile']['controller_manager']
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
      RestartSec: '30s',
      LimitNOFILE: node['kubernetes']['limits']['nofile']['scheduler']
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
      RestartSec: '30s',
      LimitNOFILE: node['kubernetes']['limits']['nofile']['addon_manager']
    },
    Install: {
      WantedBy: 'multi-user.target'
    }
  )
  notifies :restart, 'systemd_unit[kube-addon-manager.service]'
  subscribes :restart, 'template[/usr/local/bin/kube-addon-manager]'
  action [:create, :enable, :start]
end
