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

end

end

  end
end
