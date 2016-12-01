#
# Cookbook Name:: kubernetes
# Recipe:: etcd
#
# Author:: Maxim Filatov <bregor@evilmartians.com>
#

nodes = search(:node, "role:etcd").map {|node| internal_ip(node)}
initial_cluster = nodes.map {|addr| "#{addr}=#{node['etcd']['proto']}://#{addr}:#{node['etcd']['server_port']}"}.join ','

directory '/etc/kubernetes/manifests' do
  recursive true
end

template "/etc/kubernetes/manifests/etcd.yaml" do
  source "etcd.yaml.erb"
  variables(initial_cluster: initial_cluster)
end
