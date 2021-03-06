default['kubernetes']['api']['bind_address']                            = '0.0.0.0'
default['kubernetes']['api']['secure_port']                             = 8443
default['kubernetes']['api']['service_cluster_ip_range']                = '10.222.0.0/16'
default['kubernetes']['api']['storage_backend']                         = 'etcd3'
default['kubernetes']['api']['storage_media_type']                      = 'application/vnd.kubernetes.protobuf'
default['kubernetes']['api']['kubelet_https']                           = true
default['kubernetes']['api']['kubelet_certificate_authority']           = node['kubernetes']['client_ca_file']
default['kubernetes']['api']['encryption_provider_config']              = '/etc/kubernetes/encryption-config.yaml'
default['kubernetes']['api']['kubelet_client_certificate']              = node['kubernetes']['kubelet_client_cert_file']
default['kubernetes']['api']['kubelet_client_key']                      = node['kubernetes']['kubelet_client_key_file']
default['kubernetes']['api']['kubelet_preferred_address_types']         = 'InternalIP,ExternalIP,InternalDNS,ExternalDNS,Hostname'
default['kubernetes']['api']['endpoint_reconciler_type']                = 'lease' # Other possible values: 'master-count', 'none'
default['kubernetes']['api']['etcd_certfile']                           = node['kubernetes']['etcd_client_cert_file']
default['kubernetes']['api']['etcd_keyfile']                            = node['kubernetes']['etcd_client_key_file']
default['kubernetes']['api']['etcd_cafile']                             = node['kubernetes']['etcd_server_cafile']
default['kubernetes']['api']['etcd_healthcheck_timeout']                = '2s'
default['kubernetes']['api']['allow_privileged']                        = true
default['kubernetes']['api']['authorization_mode']                      = node['kubernetes']['authorization']['mode']
default['kubernetes']['api']['enable_bootstrap_token_auth']             = nil
default['kubernetes']['api']['tls_cert_file']                           = node['kubernetes']['tls_cert_file']
default['kubernetes']['api']['tls_private_key_file']                    = node['kubernetes']['tls_private_key_file']
default['kubernetes']['api']['client_ca_file']                          = node['kubernetes']['client_ca_file']
default['kubernetes']['api']['service_account_key_file']                = node['kubernetes']['service_account_cert_file']
default['kubernetes']['api']['service_account_signing_key_file']        = node['kubernetes']['service_account_key_file']
default['kubernetes']['api']['service_account_issuer']                  = 'kubernetes/serviceaccount'
default['kubernetes']['api']['service_account_extend_token_expiration'] = true
default['kubernetes']['api']['api_audiences']                           = 'api'
default['kubernetes']['api']['proxy_client_cert_file']                  = node['kubernetes']['proxy_client_cert_file']
default['kubernetes']['api']['proxy_client_key_file']                   = node['kubernetes']['proxy_client_key_file']
default['kubernetes']['api']['requestheader_client_ca_file']            = node['kubernetes']['requestheader_client_ca_file']
default['kubernetes']['api']['requestheader_allowed_names']             = 'front-proxy-client'
default['kubernetes']['api']['requestheader_extra_headers_prefix']      = 'X-Remote-Extra-'
default['kubernetes']['api']['requestheader_group_headers']             = 'X-Remote-Group'
default['kubernetes']['api']['requestheader_username_headers']          = 'X-Remote-User'
default['kubernetes']['api']['log_dir']                                 = '/var/log/kubernetes'
default['kubernetes']['api']['feature_gates']                           = node['kubernetes']['feature_gates']
default['kubernetes']['api']['enable_garbage_collector']                = true
default['kubernetes']['api']['logging_format']                          = node['kubernetes']['logging_format']
default['kubernetes']['api']['audit_log_compress']                      = true
default['kubernetes']['api']['enable_admission_plugins']                = %w(
  DefaultStorageClass
  DefaultTolerationSeconds
  LimitRanger
  MutatingAdmissionWebhook
  NamespaceLifecycle
  NodeRestriction
  PersistentVolumeClaimResize
  Priority
  ResourceQuota
  ServiceAccount
  TaintNodesByCondition
  ValidatingAdmissionWebhook).join(',')
default['kubernetes']['api']['runtime_config']                          = %w(
  storage.k8s.io/v1alpha1=true
).join(',')

if node['kubernetes']['api']['feature_gates']['APIServerIdentity']
  default['kubernetes']['api']['identity_lease_duration_seconds']         = 3600
  default['kubernetes']['api']['identity_lease_renew_interval_seconds']   = 10
end
