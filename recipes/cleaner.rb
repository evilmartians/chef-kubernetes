#
# Cookbook Name:: kubernetes
# Recipe:: cleaner
#
# Author:: Maxim Filatov <bregor@evilmartians.com>
#

require 'fileutils'

%w(
  apiserver
  controller-manager
  scheduler
  proxy
  addon-manager
).each do |srv|
  file "/etc/kubernetes/manifests/#{srv}.yaml" do
    action :delete
    only_if do
      %(systemd upstart).include? node['kubernetes']['install_via']
    end
  end

  systemd_unit "kube-#{srv}.service" do
    action [:disable, :stop, :delete]
    only_if do
      node['init_package'] == 'systemd' and
        %w(static_pods upstart).include? node['kubernetes']['install_via']
    end
  end
end

# Cleanup old kubernetes binaries
versions = Dir['/opt/kubernetes/*'].sort_by { |f| File.mtime(f) }

FileUtils.rm_rf(versions[0...-node['kubernetes']['keep_versions']])

# Cleanup old skydns manifests
%w(
  kubedns-cm
  kubedns-sa
  skydns-deployment
  skydns-svc
).each do |manifest|
  file "/etc/kubernetes/addons/#{manifest}.yaml" do
    action :delete
  end
end

# Cleanup DNS RBAC manifest when using kubedns
if node['kubernetes']['addons']['dns']['controller'] == 'kubedns'
  %w(clusterrole clusterrolebinding).each do |manifest|
    file "/etc/kubernetes/addons/dns-#{manifest}.yaml" do
      action :delete
    end
  end
end

# Cleanup static kubelet kubeconfig and keypair
file '/etc/kubernetes/kubelet_config.yaml' do
  action :delete
end

%w(crt key).each do |f|
  file "/etc/kubernetes/ssl/kubelet.#{f}" do
    action :delete
  end
end

# Kubelet clusterrolebinding
file '/etc/kubernetes/addons/kubelet-clusterrolebinding.yaml' do
  action :delete
end

# Delete weave-related resources when canal is used as SDN
if node['kubernetes']['sdn'] == 'canal'
  %w(
    sa
    clusterrole
    clusterrolebinding
    role
    rolebinding
    daemonset
  ).each do |addon|
    file "/etc/kubernetes/addons/weave-kube-#{addon}.yaml" do
      action :delete
    end
  end

  %w(10-weave.conflist 10-weave.conf).each do |config|
    file "/etc/cni/net.d/#{config}.yaml" do
      action :delete
    end
  end
end

# Delete canal-related resources when weave is used as SDN
if node['kubernetes']['sdn'] == 'weave'
  %w(
    sa
    calico-clusterrole
    calico-clusterrolebinding
    flannel-clusterrole
    flannel-clusterrolebinding
    bgppeer-crd
    globalbgpconfigs-crd
    globalfelixconfigs-crd
    globalnetworkpolicies-crd
    ippools-crd
    configmap
    daemonset
  ).each do |addon|
    file "/etc/kubernetes/addons/canal-#{addon}.yaml" do
      action :delete
    end
  end

  %w(10-calico.conflist calico-kubeconfig).each do |config|
    file "/etc/cni/net.d/#{config}.yaml" do
      action :delete
    end
  end
end
