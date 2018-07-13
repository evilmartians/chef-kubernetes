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
  bgppeers-crd
  bgpconfigurations-crd
  hostendpoints-crd
  clusterinformations-crd
  felixconfigurations-crd
  globalnetworkpolicies-crd
  globalnetworksets-crd
  networkpolicies-crd
  ippools-crd
  configmap
  daemonset
  typha-service
  typha-deployment
).each do |addon|
  template "/etc/kubernetes/addons/canal-#{addon}.yaml" do
    source "canal-#{addon}.yaml.erb"
  end
end
