default['kubernetes']['container_engine']                   = 'docker'
default['kubernetes']['roles']['master']                    = 'kubernetes_master'
default['kubernetes']['roles']['node']                      = 'kubernetes_node'
default['kubernetes']['install_via']                        = 'systemd' # other possible values are: static_pods, upstart
default['kubernetes']['databag']                            = 'kubernetes'
default['kubernetes']['version']                            = 'v1.10.0'
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
default['kubernetes']['checksums']['apiserver']             = '26fa5742f2418ebf8fbcbf54134f5477a40551d0b80eae9057d24a594b0fcb3d'
default['kubernetes']['checksums']['controller-manager']    = '30f1005ffe9f5a823842e7efc21724c171afe149e091463ef2d7d2d57ab96ee6'
default['kubernetes']['checksums']['proxy']                 = '1875d5e5faaf8eac78e0994926f813e41fab5522d5508e7a95a62a634556d3d4'
default['kubernetes']['checksums']['scheduler']             = '29fe0ac536f762ad9592a47804a87dd3ba24d97ad081f819c763ae25e316584d'
default['kubernetes']['checksums']['kubectl']               = '49f7e5791d7cd91009c728eb4dc1dbf9ee1ae6a881be6b970e631116065384c3'
default['kubernetes']['checksums']['kubelet']               = 'e048eb9319cc842771a143f8e52b08bbe96980834011e2ab0f89c1aa6f45bbcc'
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
