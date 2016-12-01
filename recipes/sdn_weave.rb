#
# Cookbook Name:: kubernetes
# Recipe:: sdn_weave
#
# Author:: Maxim Filatov <bregor@evilmartians.com>
#

['/opt/cni/bin', '/etc/cni/net.d'].each do |dir|
  directory dir do
    recursive true
  end
end

template '/etc/cni/net.d/10-weave.conf' do
  source 'weave.conf.erb'
end
