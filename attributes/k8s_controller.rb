default['kubernetes']['controller_manager']['secure_port']                      = 10257
default['kubernetes']['controller_manager']['leader_elect']                     = true
default['kubernetes']['controller_manager']['cluster_cidr']                     = node['kubernetes']['cluster_cidr']
default['kubernetes']['controller_manager']['cluster_name']                     = node['kubernetes']['cluster_name']
default['kubernetes']['controller_manager']['service_account_private_key_file'] = node['kubernetes']['service_account_key_file']
default['kubernetes']['controller_manager']['root_ca_file']                     = node['kubernetes']['client_ca_file']
default['kubernetes']['controller_manager']['tls_cert_file']                    = node['kubernetes']['controller_manager_cert_file']
default['kubernetes']['controller_manager']['tls_private_key_file']             = node['kubernetes']['controller_manager_key_file']
default['kubernetes']['controller_manager']['requestheader_client_ca_file']     = node['kubernetes']['requestheader_client_ca_file']
default['kubernetes']['controller_manager']['feature_gates']                    = node['kubernetes']['feature_gates']
default['kubernetes']['controller_manager']['controllers']                      = '*,bootstrapsigner,tokencleaner'
default['kubernetes']['controller_manager']['use_service_account_credentials']  = 'true'
default['kubernetes']['controller_manager']['node_monitor_period']              = '2s'
default['kubernetes']['controller_manager']['node_monitor_grace_period']        = '16s'
default['kubernetes']['controller_manager']['pod_eviction_timeout']             = '30s'
default['kubernetes']['controller_manager']['kubeconfig']                       = '/etc/kubernetes/controller-manager-config.yaml'
default['kubernetes']['controller_manager']['authentication_kubeconfig']        = '/etc/kubernetes/controller-manager-config.yaml'
default['kubernetes']['controller_manager']['authorization_kubeconfig']         = '/etc/kubernetes/controller-manager-config.yaml'
default['kubernetes']['controller_manager']['logging_format']                   = node['kubernetes']['logging_format']
default['kubernetes']['controller_manager']['cluster_signing_duration']         = '8760h0m0s'

default['kubernetes']['controller_manager']['horizontal_pod_autoscaler_sync_period']               = '15s'
default['kubernetes']['controller_manager']['horizontal_pod_autoscaler_tolerance']                 = 0.1
default['kubernetes']['controller_manager']['horizontal_pod_autoscaler_cpu_initialization_period'] = '5m0s'
default['kubernetes']['controller_manager']['horizontal_pod_autoscaler_downscale_stabilization']   = '5m0s'
default['kubernetes']['controller_manager']['horizontal_pod_autoscaler_initial_readiness_delay']   = '30s'

default['kubernetes']['controller_manager']['enable_garbage_collector'] = true
default['kubernetes']['controller_manager']['concurrent_gc_syncs']      = 20

default['kubernetes']['controller_manager']['cluster_signing_kube_apiserver_client_cert_file']  = node['kubernetes']['cluster_signing_kube_apiserver_client_cert_file']
default['kubernetes']['controller_manager']['cluster_signing_kube_apiserver_client_key_file']   = node['kubernetes']['cluster_signing_kube_apiserver_client_key_file']
default['kubernetes']['controller_manager']['cluster_signing_kubelet_client_cert_file']  = node['kubernetes']['cluster_signing_kubelet_client_cert_file']
default['kubernetes']['controller_manager']['cluster_signing_kubelet_client_key_file']   = node['kubernetes']['cluster_signing_kubelet_client_key_file']
default['kubernetes']['controller_manager']['cluster_signing_kubelet_serving_cert_file'] = node['kubernetes']['cluster_signing_kubelet_serving_cert_file']
default['kubernetes']['controller_manager']['cluster_signing_kubelet_serving_key_file']  = node['kubernetes']['cluster_signing_kubelet_serving_key_file']
default['kubernetes']['controller_manager']['cluster_signing_legacy_unknown_cert_file']  = node['kubernetes']['cluster_signing_legacy_unknown_cert_file']
default['kubernetes']['controller_manager']['cluster_signing_legacy_unknown_key_file']   = node['kubernetes']['cluster_signing_legacy_unknown_key_file']
