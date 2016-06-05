#
# Cookbook Name:: kubernetes
# Recipe:: default
#
# Author:: Maxim Filatov <bregor@evilmartians.com>
#

# include_recipe 'kubernetes::docker_install'

%w(manifests tokens ssl addons).each do |dir|
  directory("/etc/kubernetes/#{dir}") do
    recursive true
  end
end

template '/etc/kubernetes/kubeconfig.yaml' do
  source 'kubeconfig.yaml.erb'
end

template '/etc/kubernetes/manifests/proxy.yaml' do
  source 'proxy.yaml.erb'
end

%w(kubelet kubectl).each do |f|
  remote_file "/usr/local/bin/#{f}" do
    source "https://storage.googleapis.com/kubernetes-release/release/#{node[:kubernetes][:version]}/bin/linux/amd64/#{f}"
    mode '0755'
    not_if { Digest::MD5.file("/usr/local/bin/#{f}").to_s == node[:kubernetes][:md5][f.to_sym] rescue false }
  end
end
