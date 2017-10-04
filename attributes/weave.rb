default['kubernetes']['weave']['version']                 = '2.0.4'
default['kubernetes']['weave']['network']                 = '192.168.0.0/16'
default['kubernetes']['weave']['interface']               = 'eth1'
default['kubernetes']['weave']['use_scope']               = true
default['kubernetes']['weave']['use_portmap']             = false
default['kubernetes']['weave']['update_strategy']['type'] = 'OnDelete'
default['kubernetes']['weavescope']['version']            = '0.17.1'
default['kubernetes']['weavescope']['port']               = '4040'
