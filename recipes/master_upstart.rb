#
# Cookbook Name:: kubernetes
# Recipe:: master_upstart
#
# Author:: Kirill Kuznetsov <kir@evilmartians.com>
#

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
    cmd: '/usr/local/bin/kube-addon-manager'
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
    source "#{node['kubernetes']['paskages']['storage_url']}kube-#{f}"
    mode '0755'
    checksum node['kubernetes']['checksums'][f]
  end

  link "/usr/local/bin/kube-#{f}" do
    to "/opt/kubernetes/#{node['kubernetes']['version']}/bin/kube-#{f}"
    notifies :restart, "service[kube-#{f}]"
  end
end
