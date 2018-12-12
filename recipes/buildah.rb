#
# Cookbook Name:: kubernetes
# Recipe:: buildah
#
# Author:: Maxim Filatov <bregor@evilmartians.com>
#

package 'seccomp'

directory("/opt/buildah/#{node['kubernetes']['buildah']['version']}") { recursive true }

remote_file "/opt/buildah/#{node['kubernetes']['buildah']['version']}/buildah" do
  source "https://s3-eu-west-1.amazonaws.com/crio-binaries/#{node['lsb']['codename']}/buildah/v#{node['kubernetes']['buildah']['version']}/buildah"
  mode '0755'
  checksum node['kubernetes']['checksums']['buildah'][node['lsb']['codename']]
end

link('/usr/local/bin/buildah') { to "/opt/buildah/#{node['kubernetes']['buildah']['version']}/buildah" }
