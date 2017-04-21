#
# Cookbook Name:: kubernetes
# Recipe:: proxy
#
# Author:: Maxim Filatov <bregor@evilmartians.com>
#

include_recipe 'kubernetes::kubeconfig'

proxy_args = [
  "--bind-address=#{Chef::Recipe.allocate.internal_ip(node)}",
  "--hostname_override=#{Chef::Recipe.allocate.hostname(node)}",
  '--proxy-mode=iptables',
  '--kubeconfig=/etc/kubernetes/kubeconfig.yaml'
]

if node['kubernetes']['install_via'] == 'static_pods'

  directory '/etc/kubernetes/manifests' do
    recursive true
  end

  template '/etc/kubernetes/manifests/proxy.yaml' do
    source 'proxy.yaml.erb'
  end

end

if node['kubernetes']['install_via'] == 'systemd_units'

  systemd_service 'kube-proxy' do
    description 'Systemd unit for Kubernetes Proxy'
    action [:create, :enable, :start]
    after %w(network.target remote-fs.target)
    install do
      wanted_by 'multi-user.target'
    end
    service do
      type 'simple'
      user 'root'
      exec_start "/usr/local/bin/kube-proxy #{proxy_args.join(" \\\n")}"
      exec_reload '/bin/kill -HUP $MAINPID'
      working_directory '/'
      restart 'on-failure'
      restart_sec '30s'
    end
  end

  directory "/opt/kubernetes/#{node['kubernetes']['version']}/bin" do
    recursive true
  end

  remote_file "/opt/kubernetes/#{node['kubernetes']['version']}/bin/kube-proxy" do
    source "https://storage.googleapis.com/kubernetes-release/release/#{node['kubernetes']['version']}/bin/linux/amd64/kube-proxy"
    mode '0755'
    not_if do
      begin
        Digest::MD5.file("/opt/kubernetes/#{node['kubernetes']['version']}/bin/kube-proxy").to_s == node['kubernetes']['md5']['proxy']
      rescue
        false
      end
    end
  end
  link '/usr/local/bin/kube-proxy' do
    to "/opt/kubernetes/#{node['kubernetes']['version']}/bin/kube-proxy"
    notifies :restart, 'systemd_service[kube-proxy]'
  end
end

if node['kubernetes']['install_via'] == 'upstart'
  template '/etc/init/kube-proxy.conf' do
    source 'upstart.conf.erb'
    owner 'root'
    group 'root'
    mode '0644'
    variables(
      service_description: 'Kubernetes proxy daemon',
      cmd: "/usr/local/bin/kube-proxy #{proxy_args.join(' ')}"
    )
  end

  directory "/opt/kubernetes/#{node['kubernetes']['version']}/bin" do
    recursive true
  end

  remote_file "/opt/kubernetes/#{node['kubernetes']['version']}/bin/kube-proxy" do
    source "https://storage.googleapis.com/kubernetes-release/release/#{node['kubernetes']['version']}/bin/linux/amd64/kube-proxy"
    mode '0755'
    not_if do
      begin
        Digest::MD5.file("/opt/kubernetes/#{node['kubernetes']['version']}/bin/kube-proxy").to_s == node['kubernetes']['md5']['proxy']
      rescue
        false
      end
    end
  end

  link '/usr/local/bin/kube-proxy' do
    to "/opt/kubernetes/#{node['kubernetes']['version']}/bin/kube-proxy"
  end

  service 'kube-proxy' do
    action [:start, :enable]
    provider Chef::Provider::Service::Upstart
    subscribes :restart, 'link[/usr/local/bin/kube-proxy]'
  end

end
