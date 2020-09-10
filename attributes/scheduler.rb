default['kubernetes']['scheduler']['secure_port']          = 10259
default['kubernetes']['scheduler']['leader_elect']         = true
default['kubernetes']['scheduler']['logging_format']       = node['kubernetes']['logging_format']
default['kubernetes']['scheduler']['feature_gates']        = node['kubernetes']['feature_gates']
default['kubernetes']['scheduler']['tls_cert_file']        = node['kubernetes']['scheduler_cert_file']
default['kubernetes']['scheduler']['tls_private_key_file'] = node['kubernetes']['scheduler_key_file']

default['kubernetes']['scheduler']['kubeconfig']                = '/etc/kubernetes/scheduler-config.yaml'
default['kubernetes']['scheduler']['authentication_kubeconfig'] = '/etc/kubernetes/scheduler-config.yaml'
default['kubernetes']['scheduler']['authorization_kubeconfig']  = '/etc/kubernetes/scheduler-config.yaml'
