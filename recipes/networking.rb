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

ifaddr, ifopts = node['network']['interfaces'][node['kubernetes']['interface']]['addresses'].find { |addr, opts| opts['family'] == 'inet' }

if node['init_package'] == 'systemd'

  service 'systemd-networkd' do
    action [:enable, :start]
  end

  execute 'reload-systemd' do
    command '/bin/systemctl daemon-reload'
    action :nothing
  end

  directory '/etc/systemd/network' do
    owner 'root'
    group 'root'
    mode '0755'
    action :create
  end

  file '/etc/systemd/network/kubernetes_services.network' do
    owner 'root'
    group 'root'
    mode '0644'
    content <<-EOF
[Match]
Name = eth1

[Address]
Address = #{ifaddr}/#{ifopts['prefixlen']}

[Route]
Destination = #{node['kubernetes']['api']['service_cluster_ip_range']}
Scope = link
EOF
    notifies :run, 'execute[reload-systemd]', :immediately
  end

  # systemd_network 'kubernetes_services' do
  #   address_address "#{ifaddr}/#{ifopts['prefixlen']}"
  #   match_name node['kubernetes']['interface']
  #   route do
  #     destination node['kubernetes']['api']['service_cluster_ip_range']
  #     scope 'link'
  #   end
  #   notifies :restart, 'service[systemd-networkd]'
  # end
end

if node['init_package'] == 'init' and node['packages'].key?('upstart')

  template '/etc/init/kube-service-network-route.conf' do
    source 'kubernetes_services_upstart.conf.erb'
    owner 'root'
    group 'root'
    mode '0644'
  end

  service 'kube-service-network-route' do
    action [:start, :enable]
    provider Chef::Provider::Service::Upstart
    subscribes :restart, 'template[/etc/init/kube-service-network-route.conf]'
  end

end
