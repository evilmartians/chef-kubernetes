#
# Cookbook Name:: kubernetes
# Recipe:: master_static_pods
#
# Author:: Maxim Filatov <bregor@evilmartians.com>
#

etcd_nodes = search(
  :node,
  "roles:#{node['etcd']['role']}"
).map { |node| get_ip_address(node) }

etcd_servers = etcd_nodes.map do |addr|
  "#{node['etcd']['proto']}://#{addr}:#{node['etcd']['client_port']}"
end.join ','

master_nodes = search(:node, "roles:#{node['kubernetes']['roles']['master']}")

%w(
  apiserver
  controller-manager
  scheduler
  addon-manager
).each do |srv|
  template "/etc/kubernetes/manifests/#{srv}.yaml" do
    source "#{srv}.yaml.erb"
    variables(
      etcd_servers: etcd_servers,
      apiserver_count: master_nodes.size
    )
  end
end
