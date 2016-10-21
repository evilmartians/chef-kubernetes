#
# Cookbook Name:: kubernetes
# Recipe:: haproxy
#
# Author:: Maxim Filatov <bregor@evilmartians.com>
#

apt_repository 'haproxy' do
  uri 'ppa:vbernat/haproxy-1.6'
  distribution node['lsb']['codename']
end

package 'haproxy'

service 'haproxy' do
  action :nothing
end

master_nodes = search(:node, "role:#{node[:kubernetes][:roles][:master]}").map {|node| {name: hostname(node), ip: internal_ip(node)} }

template '/etc/haproxy/haproxy.cfg' do
  source 'haproxy.cfg.erb'
  variables(nodes: master_nodes)
  notifies :restart, 'service[haproxy]'
end
