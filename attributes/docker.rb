default['kubernetes']['docker']['built-in']                   = true

if node['platform_version'].to_i == 16
  default['kubernetes']['docker']['version']                  = '17.03.3~ce-0~ubuntu-xenial'
else
  default['kubernetes']['docker']['version']                  = '18.06.1~ce~3-0~ubuntu'
end

default['kubernetes']['docker']['settings']['storage-driver'] = 'aufs'
default['kubernetes']['docker']['settings']['live-restore']   = true
default['kubernetes']['docker']['settings']['iptables']       = false
default['kubernetes']['docker']['settings']['ip-masq']        = false
