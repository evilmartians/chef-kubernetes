#
# Cookbook Name:: kubernetes
# Recipe:: master_detect
#
# Author:: Maxim Filatov <bregor@evilmartians.com>
#

master_nodes = search(:node, "role:#{node['kubernetes']['roles']['master']}").map { |n| { name: hostname(n), ip: internal_ip(n) } }
master_url = case node['kubernetes']['multimaster']['access_via']
             when 'haproxy'
               "https://#{node['kubernetes']['multimaster']['haproxy_url']}:#{node['kubernetes']['multimaster']['haproxy_port']}"
             when 'direct'
               "https://#{master_nodes.first['ip']}:#{node['kubernetes']['secure_port']}"
             when 'dns'
               "https://#{node['kubernetes']['multimaster']['dns_name']}"
             end
node.override['kubernetes']['master'] = master_url
