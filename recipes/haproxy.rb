#
# Cookbook Name:: kubernetes
# Recipe:: haproxy
#
# Author:: Maxim Filatov <bregor@evilmartians.com>
#

require 'resolv'

apt_repository 'haproxy' do
  uri 'ppa:vbernat/haproxy-1.7'
  distribution node['lsb']['codename']
end

package 'haproxy'

service 'haproxy' do
  action :nothing
end

master_nodes = search(:node, "role:#{node['kubernetes']['roles']['master']}")
if !master_nodes.empty? && master_nodes.all? {|n| n.keys.include? 'kubernetes'}
  master_nodes.map! { |node| { name: hostname(node), ip: internal_ip(node) } }

  nameservers = Resolv::DNS::Config.new.lazy_initialize.nameserver_port
  nameservers = nameservers.unshift([node['kubernetes']['cluster_dns'], 53])
  nameservers.uniq!

  template '/etc/haproxy/haproxy.cfg' do
    source 'haproxy.cfg.erb'
    variables(
      nodes:     master_nodes,
      resolvers: [
        { name: node['kubernetes']['cluster_name'],
          nameservers:     nameservers,
          resolve_retries: 3,
          timeout_retry:   '1s'
        }
      ]
    )
    notifies :restart, 'service[haproxy]'
  end
end
