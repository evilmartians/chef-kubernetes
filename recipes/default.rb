#
# Cookbook Name:: kubernetes
# Recipe:: default
#
# Author:: Maxim Filatov <bregor@evilmartians.com>
#

# include_recipe 'kubernetes::docker_install'

bash 'install_nsenter' do
  code <<-EOH
/usr/bin/docker run --rm -v /usr/local/bin:/target jpetazzo/nsenter
chmod +x /usr/local/bin/nsenter
/usr/bin/docker rmi jpetazzo/nsenter
EOH
  not_if { File.exists? '/usr/local/bin/nsenter' }
end

package 'socat'

%w(manifests tokens ssl addons).each do |dir|
  directory("/etc/kubernetes/#{dir}") do
    recursive true
  end
end

['client_certificate', 'client_key'].each do |f|
  file node[:kubernetes][:kubelet][f.to_sym] do
    content Chef::EncryptedDataBagItem.load(node[:kubernetes][:databag], "#{node[:hostname]}_ssl")[f]
  end
end

file node[:kubernetes][:client_ca_file] do
  content Chef::EncryptedDataBagItem.load(node[:kubernetes][:databag], "#{node[:kubernetes][:cluster_name]}_cluster_ssl")['client_ca_file']
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
