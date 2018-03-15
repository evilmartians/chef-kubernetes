default['kubernetes']['container_engine']                   = 'docker'
default['kubernetes']['roles']['master']                    = 'kubernetes_master'
default['kubernetes']['roles']['node']                      = 'kubernetes_node'
default['kubernetes']['install_via']                        = 'systemd' # other possible values are: static_pods, upstart
default['kubernetes']['databag']                            = 'kubernetes'
default['kubernetes']['version']                            = 'v1.9.2'
default['kubernetes']['keep_versions']                      = 3
default['kubernetes']['image']                              = 'gcr.io/google_containers/hyperkube'
default['kubernetes']['interface']                          = 'eth1'
default['kubernetes']['enable_firewall']                    = true
default['kubernetes']['register_as']                        = 'ip'
default['kubernetes']['use_sdn']                            = true
default['kubernetes']['sdn']                                = 'weave'
default['kubernetes']['master']                             = '127.0.0.1'
default['kubernetes']['cluster_name']                       = 'kubernetes'
default['kubernetes']['cluster_dns']                        = '10.222.222.222'
default['kubernetes']['cluster_domain']                     = 'kubernetes.local'
default['kubernetes']['cluster_cidr']                       = '192.168.0.0/16'
default['kubernetes']['node_cidr_mask_size']                = 24
default['kubernetes']['use_cluster_dns_systemwide']         = false
default['kubernetes']['ssl']['keypairs']                    = %w(apiserver ca)
default['kubernetes']['ssl']['ca']['public_key']            = '/etc/kubernetes/ssl/ca.pem'
default['kubernetes']['ssl']['ca']['private_key']           = '/etc/kubernetes/ssl/ca-key.pem'
default['kubernetes']['ssl']['apiserver']['public_key']     = '/etc/kubernetes/ssl/apiserver.pem'
default['kubernetes']['ssl']['apiserver']['private_key']    = '/etc/kubernetes/ssl/apiserver-key.pem'
default['kubernetes']['kubeconfig']                         = '/etc/kubernetes/kubeconfig.yaml'
default['kubernetes']['tls_cert_file']                      = '/etc/kubernetes/ssl/apiserver.pem'
default['kubernetes']['tls_private_key_file']               = '/etc/kubernetes/ssl/apiserver-key.pem'
default['kubernetes']['client_ca_file']                     = '/etc/kubernetes/ssl/ca.pem'
default['kubernetes']['service_account_key_file']           = '/etc/kubernetes/ssl/ca-key.pem'
default['kubernetes']['cluster_signing_cert_file']          = '/etc/kubernetes/ssl/ca.pem'
default['kubernetes']['cluster_signing_key_file']           = '/etc/kubernetes/ssl/ca-key.pem'
default['kubernetes']['token_auth']                         = false
default['kubernetes']['token_auth_file']                    = '/etc/kubernetes/known_tokens.csv'
default['kubernetes']['cloud_config']                       = ''
default['kubernetes']['cloud_provider']                     = ''
default['kubernetes']['docker']                             = 'unix:///var/run/docker.sock'
default['kubernetes']['feature_gates']                      = ['RotateKubeletServerCertificate=true', 'PersistentLocalVolumes=true', 'VolumeScheduling=true', 'MountPropagation=true']
default['kubernetes']['api']['bind_address']                = '0.0.0.0'
default['kubernetes']['api']['insecure_bind_address']       = '127.0.0.1'
default['kubernetes']['api']['insecure_port']               = 8080
default['kubernetes']['api']['secure_port']                 = 8443
default['kubernetes']['api']['service_cluster_ip_range']    = '10.222.0.0/16'
default['kubernetes']['api']['admission_control']           = %w(Initializers NamespaceLifecycle NodeRestriction LimitRanger ServiceAccount DefaultStorageClass ResourceQuota)
default['kubernetes']['api']['runtime_config']              = []
default['kubernetes']['api']['storage_backend']             = 'etcd3' # Other possible values: 'etcd3'
default['kubernetes']['api']['storage_media_type']          = 'application/vnd.kubernetes.protobuf' # Other values: 'application/json'
default['kubernetes']['api']['kubelet_https']               = 'true'
default['kubernetes']['api']['kubelet_certificate_authority'] = '/etc/kubernetes/ssl/ca.pem'
default['kubernetes']['api']['kubelet_client_certificate']  = '/etc/kubernetes/ssl/apiserver.pem'
default['kubernetes']['api']['kubelet_client_key']          = '/etc/kubernetes/ssl/apiserver-key.pem'
default['kubernetes']['api']['endpoint_reconciler_type']    = 'lease' # Other possible values: 'master-count', 'none'
default['kubernetes']['audit']['enabled']                   = true
default['kubernetes']['audit']['log_file']                  = '/var/log/kubernetes/audit.log'
default['kubernetes']['audit']['maxbackup']                 = 3
default['kubernetes']['kubelet']['client_certificate']      = '/etc/kubernetes/ssl/node.pem'
default['kubernetes']['kubelet']['client_key']              = '/etc/kubernetes/ssl/node-key.pem'
default['kubernetes']['kubelet']['image_gc_low_threshold']  = '70'
default['kubernetes']['kubelet']['image_gc_high_threshold'] = '80'
default['kubernetes']['kubelet']['cadvisor_port']           = 0
default['kubernetes']['kubelet']['verbosity']               = 2
default['kubernetes']['kubelet']['register_node']           = 'true'
default['kubernetes']['kubelet']['anonymous_auth']          = 'false'
default['kubernetes']['kubelet']['client_ca_file']          = '/etc/kubernetes/ssl/ca.pem'
default['kubernetes']['kubelet']['authorization_mode']      = 'Webhook' # Other possible values: 'AlwaysAllow'
default['kubernetes']['kubelet']['fail_swap_on']            = 'false'
default['kubernetes']['packages']['storage_url']            = "https://storage.googleapis.com/kubernetes-release/release/#{node['kubernetes']['version']}/bin/linux/amd64/"
default['kubernetes']['checksums']['apiserver']             = 'c9d5b3c84cc45fad82840192ba202f828494c83f525d6cf95e95d0ead4393daf'
default['kubernetes']['checksums']['controller-manager']    = '12f800b56500d2d5d1289e2d158a9fee0eacfad2f48fc77043f76a744b1f8716'
default['kubernetes']['checksums']['proxy']                 = '27d1eba7d4b0c4a52e15c217b688ad0610e044357dfd8db81fe7fa8d41f2a895'
default['kubernetes']['checksums']['scheduler']             = '593fa5dc99614ed85be25d800cc90d82552135b28cd92de0f3f19f967fb532fd'
default['kubernetes']['checksums']['kubectl']               = '455999c8232c57748f4cee4b5446ee39fe8af093434d732ddcd628a02f3d9118'
default['kubernetes']['checksums']['kubelet']               = '56dd720c239987a2a30ea1c2ae0497788efab0477c0198f592decc74d6a0364a'
default['kubernetes']['addon_manager']['version']           = 'v6.5'
default['kubernetes']['multimaster']['access_via']          = 'haproxy' # other possible values are: direct, dns
default['kubernetes']['multimaster']['haproxy_url']         = '127.0.0.1'
default['kubernetes']['multimaster']['haproxy_port']        = 6443
default['kubernetes']['multimaster']['dns_name']            = ''
default['kubernetes']['cni']['version']                     = '0.6.0'
default['kubernetes']['cni']['plugins_version']             = '0.6.0'
default['kubernetes']['encryption']                         = 'aescbc'
default['kubernetes']['api']['experimental_encryption_provider_config'] = '/etc/kubernetes/encryption-config.yaml'
default['kubernetes']['node']['packages']                   = %w(
  iptables
  ebtables
  socat
  ethtool
  kmod
  tcpd
  dbus
  apt-transport-https
  conntrack
)
