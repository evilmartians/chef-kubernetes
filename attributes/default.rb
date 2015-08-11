default['kubernetes']['version']               = 'v1.0.1'
default['kubernetes']['interface']             = 'eth1'
default['kubernetes']['etcd']['discovery_url'] = 'http://discovery.etcd.io/80d5aed7fbcfeabf02020cce1c606b17'
default['kubernetes']['etcd']['version']       = 'v2.1.1'
default['kubernetes']['flannel']['version']    = '0.5.2'
default['kubernetes']['flannel']['network']    = {'Network' => '10.222.10.0/16'}
