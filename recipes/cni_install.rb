#
# Cookbook Name:: kubernetes
# Recipe:: cni_install
#
# Author:: Maxim Filatov <bregor@evilmartians.com>
#

plugins_version = node['kubernetes']['cni']['plugins_version']

[
  '/etc/kubernetes/addons',
  '/opt/cni/bin',
  '/etc/cni/net.d',
  "/opt/cni/plugins/#{plugins_version}",
].each do |dir|
  directory dir do
    recursive true
  end
end

tar_extract "https://github.com/containernetworking/plugins/releases/download/v#{plugins_version}/cni-plugins-linux-amd64-v#{plugins_version}.tgz" do
  target_dir "/opt/cni/plugins/#{plugins_version}"
  creates "/opt/cni/plugins/#{plugins_version}/portmap"
end

node['kubernetes']['cni']['plugins'].each do |plugin, flag|
  if flag
    link "/opt/cni/bin/#{plugin}" do
      to "../plugins/#{plugins_version}/#{plugin}"
    end
  else
    link "/opt/cni/bin/#{plugin}" do
      action :delete
      only_if "test -L /opt/cni/bin/#{plugin}"
    end
  end
end
