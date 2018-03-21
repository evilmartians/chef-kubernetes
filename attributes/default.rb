default['kubernetes']['container_engine']                   = 'docker'
default['kubernetes']['roles']['master']                    = 'kubernetes_master'
default['kubernetes']['roles']['node']                      = 'kubernetes_node'
default['kubernetes']['install_via']                        = 'systemd' # other possible values are: static_pods, upstart
default['kubernetes']['databag']                            = 'kubernetes'
default['kubernetes']['version']                            = 'v1.9.6'
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
default['kubernetes']['checksums']['apiserver']             = '0aa6e8e975a7945d9030846718869058e073c6366f7b495bc0f726f5b930db8b'
default['kubernetes']['checksums']['controller-manager']    = 'b036b6dc7f0e9c0a3591a90d60a89bd2234906305654733ecf4252177985e1af'
default['kubernetes']['checksums']['proxy']                 = '9f45fed75371c4c0e9a7f842544295448f11fcffed75154c31b561279b84a542'
default['kubernetes']['checksums']['scheduler']             = '292a0b3d2f20766e781efe07f6a93c811fb3b68b2e4f546de4a8d8b62fb8015a'
default['kubernetes']['checksums']['kubectl']               = 'e6aa618d682d0bcc90602cbf2e22a134d36af7199d7081015042eca02ba36368'
default['kubernetes']['checksums']['kubelet']               = 'f433499ea65c765d95c2f1f2bfd4d668c0cd809434719b88b55f3ab00eb4dd47'
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
