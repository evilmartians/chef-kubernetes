#
# Cookbook Name:: kubernetes
# Recipe:: sdn_weave
#
# Author:: Maxim Filatov <bregor@evilmartians.com>
#

['/opt/cni/bin', '/etc/cni/net.d'].each do |dir|
  directory dir do
    recursive true
  end
end

template '/etc/cni/net.d/10-weave.conf' do
  source 'weave.conf.erb'
end

directory '/etc/kubernetes/addons' do
  recursive true
end

['sa', 'clusterrole', 'clusterrolebinding', 'daemonset'].each do |addon|
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
