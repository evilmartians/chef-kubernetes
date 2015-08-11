#
# Cookbook Name:: kubernetes
# Recipe:: docker_install
#
# Author:: Maxim Filatov <bregor@evilmartians.com>
#

apt_repository 'docker' do
  uri "https://apt.dockerproject.org/repo"
  distribution "#{node.platform}-#{node.lsb.codename}"
  components ['main']
  keyserver 'hkp://p80.pool.sks-keyservers.net:80'
  key '58118E89F3A912897C070ADBF76221572C52609D'
end

package 'iptables'

package 'docker-engine'

service 'docker' do
  action :disable
end
