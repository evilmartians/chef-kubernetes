#
# Cookbook Name:: kubernetes
# Recipe:: proxy
#
# Author:: Maxim Filatov <bregor@evilmartians.com>
#

include_recipe 'kubernetes::kubeconfig'

if install_via == 'static_pods'

  directory '/etc/kubernetes/manifests' do
    recursive true
  end

  template '/etc/kubernetes/manifests/proxy.yaml' do
    source 'proxy.yaml.erb'
  end

end

remote_file "/opt/kubernetes/#{node['kubernetes']['version']}/bin/kube-proxy" do
  source "#{node['kubernetes']['packages']['storage_url']}kube-proxy"
  mode '0755'
  checksum node['kubernetes']['checksums']['kube-proxy']
  not_if do
    node['kubernetes']['install_via'] == 'static_pods'
  end
end

link '/usr/local/bin/kube-proxy' do
  to "/opt/kubernetes/#{node['kubernetes']['version']}/bin/kube-proxy"
  not_if do
    node['kubernetes']['install_via'] == 'static_pods'
  end
end

if install_via == 'systemd'

  directory "/opt/kubernetes/#{node['kubernetes']['version']}/bin" do
    recursive true
  end

  systemd_unit 'kube-proxy.service' do
    content(
      Unit: {
        Description: 'Systemd unit for Kubernetes Proxy',
        After: 'network.target remote-fs.target',
      },
      Service: {
        Type: 'simple',
        ExecStart: "/usr/local/bin/kube-proxy #{proxy_args.join(" \\\n")}",
        ExecReload: '/bin/kill -HUP $MAINPID',
        WorkingDirectory: '/',
        Restart: 'on-failure',
        RestartSec: '30s',
        LimitNOFILE: node['kubernetes']['limits']['nofile']['proxy'],
      },
      Install: {
        WantedBy: 'multi-user.target',
      }
    )
    notifies :restart, 'systemd_unit[kube-proxy.service]'
    subscribes :restart, "remote_file[/opt/kubernetes/#{node['kubernetes']['version']}/bin/kube-proxy]"
    action [:create, :enable, :start]
  end
end

firewall_rule 'kube_proxy' do
  port node['kubernetes']['proxy']['global']['metrics_port']
  protocol :tcp
  interface node['kubernetes']['interface']
  command :allow
  only_if do
    node['kubernetes']['enable_firewall']
  end
end
