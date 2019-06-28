default['kubernetes']['docker']['built-in']                   = true
default['kubernetes']['docker']['version']                    = '18.09.7~3-0'
default['kubernetes']['docker']['deb_version']                = '5' # use empty string if none
default['kubernetes']['docker']['settings']['storage-driver'] = 'aufs'
default['kubernetes']['docker']['settings']['live-restore']   = true
default['kubernetes']['docker']['settings']['iptables']       = false
default['kubernetes']['docker']['settings']['ip-masq']        = false
