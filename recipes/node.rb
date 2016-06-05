#
# Cookbook Name:: kubernetes
# Recipe:: node
#
# Author:: Maxim Filatov <bregor@evilmartians.com>
#

include_recipe 'kubernetes::default'

internal_ip = node[:network][:interfaces][node['kubernetes']['interface']]
              .addresses.find {|addr, properties| properties['family'] == 'inet'}.first

if Chef::Config[:solo]
  master_ip = node['kubernetes']['master']['ip']
else
  master_node = search(:node, 'role:kubernetes_master').first
  master_ip = master_node[:network][:interfaces][node['kubernetes']['interface']]
              .addresses.find {|addr, properties| properties['family'] == 'inet'}.first
end
