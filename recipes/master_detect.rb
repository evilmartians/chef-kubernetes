#
# Cookbook Name:: kubernetes
# Recipe:: master_detect
#
# Author:: Maxim Filatov <bregor@evilmartians.com>
#

master_url = case node['kubernetes']['multimaster']['access_via']
             when 'haproxy'
               "https://#{node['kubernetes']['multimaster']['haproxy_url']}:#{node['kubernetes']['multimaster']['haproxy_port']}"
             when 'dns'
               "https://#{node['kubernetes']['multimaster']['dns_name']}"
             end
node.override['kubernetes']['master'] = master_url
