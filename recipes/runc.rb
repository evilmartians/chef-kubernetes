#
# Cookbook Name:: kubernetes
# Recipe:: runc
#
# Author:: Maxim Filatov <bregor@evilmartians.com>
#

runc_version  = node['kubernetes']['runc']['version']
runsc_version = node['kubernetes']['runsc']['version']

directory("/opt/runc/#{runc_version}") { recursive true }
directory("/opt/runsc/#{runsc_version}") { recursive true }

remote_file "/opt/runc/#{runc_version}/runc" do
  source(sprintf node['kubernetes']['runc']['storage_url'], version: runc_version)
  mode '0755'
  checksum node['kubernetes']['runc']['checksum']
end

remote_file "/opt/runsc/#{runsc_version}/runsc" do
  source(sprintf node['kubernetes']['runsc']['storage_url'], version: runsc_version)
  mode '0755'
  checksum node['kubernetes']['runsc']['checksum']
end

link('/usr/local/bin/runc')  { to "/opt/runc/#{runc_version}/runc" }
link('/usr/local/bin/runsc') { to "/opt/runsc/#{runsc_version}/runsc" }
