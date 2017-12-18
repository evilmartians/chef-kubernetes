#
# Cookbook Name:: kubernetes
# Recipe:: master_static_pods
#
# Author:: Maxim Filatov <bregor@evilmartians.com>
#

etcd_nodes = search(
  :node,
  "roles:#{node['etcd']['role']}"
).map { |node| k8s_ip(node) }

etcd_servers = etcd_nodes.map do |addr|
  "#{node['etcd']['proto']}://#{addr}:#{node['etcd']['client_port']}"
end.join ','

if etcd_nodes.empty?
  etcd_servers = "#{node['etcd']['proto']}://#{k8s_ip(node)}:#{node['etcd']['client_port']}"
end

master_nodes = search(:node, "roles:#{node['kubernetes']['roles']['master']}")

master_nodes = [node] if master_nodes.empty?

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
