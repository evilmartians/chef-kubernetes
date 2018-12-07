default['kubernetes']['controller_manager']['secure_port']                      = 10257
default['kubernetes']['controller_manager']['leader_elect']                     = true
default['kubernetes']['controller_manager']['cluster_cidr']                     = node['kubernetes']['cluster_cidr']
default['kubernetes']['controller_manager']['cluster_name']                     = node['kubernetes']['cluster_name']
default['kubernetes']['controller_manager']['service_account_private_key_file'] = node['kubernetes']['service_account_key_file']
default['kubernetes']['controller_manager']['cluster_signing_cert_file']        = node['kubernetes']['cluster_signing_cert_file']
default['kubernetes']['controller_manager']['cluster_signing_key_file']         = node['kubernetes']['cluster_signing_key_file']
default['kubernetes']['controller_manager']['root_ca_file']                     = node['kubernetes']['client_ca_file']
default['kubernetes']['controller_manager']['master']                           = "http://127.0.0.1:#{node['kubernetes']['api']['insecure_port']}"
default['kubernetes']['controller_manager']['feature_gates']                    = node['kubernetes']['feature_gates']
default['kubernetes']['controller_manager']['node_monitor_period']              = '2s'
default['kubernetes']['controller_manager']['node_monitor_grace_period']        = '16s'
default['kubernetes']['controller_manager']['pod_eviction_timeout']             = '30s'

default['kubernetes']['controller_manager']['horizontal_pod_autoscaler_sync_period']      = '30s'
default['kubernetes']['controller_manager']['horizontal_pod_autoscaler_tolerance']        = 0.1
