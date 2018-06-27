#
# Cookbook Name:: kubernetes
# Recipe:: network
#
# Author:: Maxim Filatov <bregor@evilmartians.com>
#

if node['kubernetes']['use_cluster_dns_systemwide']
  require 'resolv'
  include_recipe 'network_interfaces_v2'
  nameservers = Resolv::DNS::Config.new.lazy_initialize.nameserver_port.map(&:first)
  nameservers = Array(node['kubernetes']['cluster_dns']) + nameservers
  nameservers.uniq!
  network_interface 'lo' do
    custom 'dns-nameservers' => nameservers.join(' ')
  end
end

if node['init_package'] == 'systemd'
  systemd_unit 'kube-service-network-route.service' do
    content(
      Unit: {
        Description: 'Kubernetes services network route',
        After: 'network.target',
      },
      Service: {
        Type: 'oneshot',
        RemainAfterExit: 'true',
        ExecStop: "/sbin/ip route del #{node['kubernetes']['api']['service_cluster_ip_range']}",
        ExecStart: "/sbin/ip route replace #{node['kubernetes']['api']['service_cluster_ip_range']} dev #{node['kubernetes']['interface']}",
      },
      Install: {
        WantedBy: 'multi-user.target kubelet.service',
      }
    )
    action [:create, :enable, :start]
    notifies :restart, 'systemd_unit[kube-service-network-route.service]'
  end
end
