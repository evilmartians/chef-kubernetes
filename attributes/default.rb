default['kubernetes']['version']               = 'v1.1.1'
default['kubernetes']['interface']             = 'eth1'
default['kubernetes']['cluster-name']          = 'kubernetes'
default['kubernetes']['cluster_dns']           = '10.222.222.222'
default['kubernetes']['cluster_domain']        = 'kubernetes.local'
default['kubernetes']['etcd']['discovery_url'] = ''
default['kubernetes']['etcd']['version']       = 'v2.2.1'
default['kubernetes']['flannel']['version']    = '0.5.4'
default['kubernetes']['flannel']['network']    = {'Network' => '10.222.10.0/16'}
