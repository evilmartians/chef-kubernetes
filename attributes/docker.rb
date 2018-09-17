default['docker']['built-in']                   = true

if node['platform_version'].to_i == 16
  default['docker']['version']                  = '17.03.3~ce-0~ubuntu-xenial'
else
  default['docker']['version']                  = '18.06.1~ce~3-0~ubuntu'
end

default['docker']['settings']['storage-driver'] = 'aufs'
default['docker']['settings']['live-restore']   = true
default['docker']['settings']['iptables']       = false
default['docker']['settings']['ip-masq']        = false
