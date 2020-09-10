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

  service 'docker' do
    action :nothing
  end

  directory '/etc/docker'

  file '/etc/docker/daemon.json' do
    owner 'root'
    group 'root'
    mode '0644'
    content(node['kubernetes']['docker']['settings'].to_json)
    notifies :restart, 'service[docker]'
  end

  version = "#{node['kubernetes']['docker']['version']}~#{node['lsb']['id'].downcase}-#{node['lsb']['codename']}"
  deb_version = node['kubernetes']['docker']['deb_version']
  version = [deb_version, version].join(':') unless deb_version.empty?

  %w(docker-ce docker-ce-cli).each do |pkg|
    apt_preference pkg do
      pin          "version #{version}"
      pin_priority '700'
    end

    package pkg do
      options '-o Dpkg::Options::="--force-confold"'
      action :upgrade
    end
  end

end
