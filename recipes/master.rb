#
# Cookbook Name:: kubernetes
# Recipe:: master
#
# Author:: Maxim Filatov <bregor@evilmartians.com>
#

include_recipe 'kubernetes::default'

['etcd', 'apiserver', 'controller-manager', 'scheduler', 'addon-manager'].each do |srv|
  template "/etc/kubernetes/manifests/#{srv}.yaml" do
    source "#{srv}.yaml.erb"
  end
end

end

end

[:client_ca_file, :tls_cert_file, :tls_private_key_file].each do |f|
  file node[:kubernetes][f] do
    content Chef::EncryptedDataBagItem.load(node[:kubernetes][:databag], "#{node[:kubernetes][:cluster_name]}_#{f}")['body']
  end
end
