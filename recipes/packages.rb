#
# Cookbook Name:: kubernetes
# Recipe:: packages
#
# Author:: Maxim Filatov <bregor@evilmartians.com>
#

node['kubernetes']['node']['packages'].each do |pkg|
  package pkg
end

if node['docker']['built-in']
  package 'linux-image-extra-virtual' if node['docker']['settings']['storage-driver'] == 'aufs'

  apt_repository 'docker' do
    uri 'https://apt.dockerproject.org/repo'
    distribution "#{node['platform']}-#{node['lsb']['codename']}"
    components ['main']
    keyserver 'hkp://p80.pool.sks-keyservers.net:80'
    key '58118E89F3A912897C070ADBF76221572C52609D'
  end

  directory '/etc/docker'

  file '/etc/docker/daemon.json' do
    owner 'root'
    group 'root'
    mode '0644'
    content(node['docker']['settings'].to_json)
  end

  apt_preference 'docker-engine' do
    pin          "version #{node['docker']['version']}~#{node['platform']}-#{node['lsb']['codename']}"
    pin_priority '700'
  end

  package 'docker-engine' do
    options '-o Dpkg::Options::="--force-confold"'
  end
end

bash 'install_nsenter' do
  code <<-EOH
/usr/bin/docker run --rm -v /usr/local/bin:/target jpetazzo/nsenter
chmod +x /usr/local/bin/nsenter
/usr/bin/docker rmi jpetazzo/nsenter
EOH
  not_if { File.exist? '/usr/local/bin/nsenter' }
end

directory "/opt/kubernetes/#{node['kubernetes']['version']}/bin" do
  recursive true
end

%w(kubelet kubectl).each do |f|
  remote_file "/opt/kubernetes/#{node['kubernetes']['version']}/bin/#{f}" do
    source "#{node['kubernetes']['packages']['storage_url']}#{f}"
    mode '0755'
    checksum node['kubernetes']['checksums'][f]
  end
end

link '/usr/local/bin/kubectl' do
  to "/opt/kubernetes/#{node['kubernetes']['version']}/bin/kubectl"
end
