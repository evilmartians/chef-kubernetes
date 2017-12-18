#
# Cookbook Name:: kubernetes
# Recipe:: sdn_canal
#
# Author:: Maxim Filatov <bregor@evilmartians.com>
#

include_recipe 'kubernetes::cni_install'

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
  template "/etc/kubernetes/addons/canal-#{addon}.yaml" do
    source "canal-#{addon}.yaml.erb"
  end
end
