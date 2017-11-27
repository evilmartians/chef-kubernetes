#
# Cookbook Name:: kubernetes
# Recipe:: sdn_weave
#
# Author:: Maxim Filatov <bregor@evilmartians.com>
#

include_recipe 'kubernetes::cni_install'

template '/etc/cni/net.d/10-weave.conflist' do
  source 'weave-portmap.conf.erb'
  action node['kubernetes']['weave']['use_portmap'] ? :create : :delete
end

template '/etc/cni/net.d/10-weave.conf' do
  source 'weave.conf.erb'
  action node['kubernetes']['weave']['use_portmap'] ? :delete : :create
end

directory '/etc/kubernetes/addons' do
  recursive true
end

['sa', 'clusterrole', 'clusterrolebinding', 'role', 'rolebinding', 'daemonset'].each do |addon|
  template "/etc/kubernetes/addons/weave-kube-#{addon}.yaml" do
    source "weave-kube-#{addon}.yaml.erb"
  end
end

if node['kubernetes']['weave']['use_scope']
  ['weavescope-deployment', 'weavescope-svc', 'weavescope-daemonset']. each do |srv|
    template "/etc/kubernetes/addons/#{srv}.yaml" do
      source "#{srv}.yaml.erb"
    end
  end
end

firewall_rule 'weave_to_node' do
  interface node['kubernetes']['weave']['interface']
  protocol :none
  command :allow
end

firewall_rule 'weave_npc' do
  port 6781
  protocol :tcp
  interface node['kubernetes']['interface']
  command :allow
end

firewall_rule 'weave_status' do
  port 6782
  protocol :tcp
  interface node['kubernetes']['interface']
  command :allow
end

firewall_rule 'weave_control' do
  port 6783
  protocol :tcp
  interface node['kubernetes']['interface']
  command :allow
end

firewall_rule 'weave_data' do
  port [6783, 6784]
  protocol :udp
  interface node['kubernetes']['interface']
  command :allow
end
