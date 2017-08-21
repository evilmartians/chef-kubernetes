#
# Cookbook Name:: kubernetes
# Recipe:: sdn_weave
#
# Author:: Maxim Filatov <bregor@evilmartians.com>
#

version         = node['kubernetes']['cni']['version']
plugins_version = node['kubernetes']['cni']['plugins_version']

['/opt/cni/bin', '/etc/cni/net.d', "/opt/cni/#{version}", "/opt/cni/plugins/#{plugins_version}"].each do |dir|
  directory dir do
    recursive true
  end
end

tar_extract "https://github.com/containernetworking/cni/releases/download/v#{version}/cni-amd64-v#{version}.tgz" do
  target_dir "/opt/cni/#{version}"
  creates "/opt/cni/#{version}/cnitool"
end

%w(cnitool noop).each do |binary|
  link "/opt/cni/bin/#{binary}" do
    to "../#{version}/#{binary}"
  end
end

tar_extract "https://github.com/containernetworking/plugins/releases/download/v#{plugins_version}/cni-plugins-amd64-v#{plugins_version}.tgz" do
  target_dir "/opt/cni/plugins/#{plugins_version}"
  creates "/opt/cni/plugins/#{plugins_version}/portmap"
end

%w(flannel ptp host-local portmap tuning vlan sample dhcp ipvlan macvlan loopback bridge).each do |plugin|
  link "/opt/cni/bin/#{plugin}" do
    to "../plugins/#{plugins_version}/#{plugin}"
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
