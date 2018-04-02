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
