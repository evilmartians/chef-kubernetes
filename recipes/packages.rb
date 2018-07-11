#
# Cookbook Name:: kubernetes
# Recipe:: packages
#
# Author:: Maxim Filatov <bregor@evilmartians.com>
#

node['kubernetes']['node']['packages'].each do |pkg, flag|
  package pkg if flag
end

if node['kubernetes']['crio']['config']['storage_driver'] == 'aufs'
  package 'aufs-tools'
end

include_recipe "kubernetes::#{node['kubernetes']['container_runtime']}"

directory "/opt/kubernetes/#{node['kubernetes']['version']}/bin" do
  recursive true
end

%w(kubelet kubectl).each do |f|
  remote_file "/opt/kubernetes/#{node['kubernetes']['version']}/bin/#{f}" do
    source "#{node['kubernetes']['packages']['storage_url']}#{f}"
    mode '0755'
    checksum node['kubernetes']['checksums'][f]
  end
end

link '/usr/local/bin/kubectl' do
  to "/opt/kubernetes/#{node['kubernetes']['version']}/bin/kubectl"
end
