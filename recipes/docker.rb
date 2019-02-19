#
# Cookbook Name:: kubernetes
# Recipe:: docker
#
# Author:: Maxim Filatov <bregor@evilmartians.com>
#

if node['kubernetes']['docker']['built-in']
  package 'linux-image-extra-virtual' if node['kubernetes']['docker']['settings']['storage-driver'] == 'aufs'

  apt_repository 'docker' do
    uri 'https://download.docker.com/linux/ubuntu'
    distribution node['lsb']['codename']
    components ['stable']
    key 'https://download.docker.com/linux/ubuntu/gpg'
  end

  directory '/etc/docker'

  file '/etc/docker/daemon.json' do
    owner 'root'
    group 'root'
    mode '0644'
    content(node['kubernetes']['docker']['settings'].to_json)
  end

  apt_preference 'docker-ce' do
    pin          "version #{node['kubernetes']['docker']['version']}"
    pin_priority '700'
  end

  package 'docker-ce' do
    options '-o Dpkg::Options::="--force-confold"'
    action :upgrade
  end

  bash 'install_nsenter' do
    code <<-EOH
    /usr/bin/docker run --rm -v /usr/local/bin:/target jpetazzo/nsenter
    chmod +x /usr/local/bin/nsenter
    /usr/bin/docker rmi jpetazzo/nsenter
  EOH
    not_if { File.exist? '/usr/local/bin/nsenter' }
  end


end
