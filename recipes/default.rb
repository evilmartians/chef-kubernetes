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

  end
end
