default['kubernetes']['proxy']['global']['config']             = '/etc/kubernetes/kube-proxy-config.yaml'
default['kubernetes']['proxy']['global']['feature_gates']      = node['kubernetes']['feature_gates']

default['kubernetes']['proxy']['metrics_port']                    = 10249
default['kubernetes']['proxy']['healthz_port']                    = 10256
default['kubernetes']['proxy']['config_sync_period']              = '15m0s'
default['kubernetes']['proxy']['detect_local_mode']               = 'ClusterCIDR'
default['kubernetes']['proxy']['enable_profiling']                = false
default['kubernetes']['proxy']['node_port_addresses']             = ''
default['kubernetes']['proxy']['oom_score_adj']                   = -999
default['kubernetes']['proxy']['port_range']                      = ''
default['kubernetes']['proxy']['show_hidden_metrics_for_version'] = ''
default['kubernetes']['proxy']['udp_idle_timeout']                = '250ms'

default['kubernetes']['proxy']['conntrack']['max_per_core']            = 32768
default['kubernetes']['proxy']['conntrack']['min']                     = 131072
default['kubernetes']['proxy']['conntrack']['tcp_close_wait_timeout']  = '1h0m0s'
default['kubernetes']['proxy']['conntrack']['tcp_established_timeout'] = '24h0m0s'

default['kubernetes']['proxy']['iptables']['masquerade_all']  = false
default['kubernetes']['proxy']['iptables']['masquerade_bit']  = 14
default['kubernetes']['proxy']['iptables']['min_sync_period'] = '0s'
default['kubernetes']['proxy']['iptables']['sync_period']     = '30s'

default['kubernetes']['proxy']['ipvs']['exclude_cidrs']   = ''
default['kubernetes']['proxy']['ipvs']['min_sync_period'] = '0s'
default['kubernetes']['proxy']['ipvs']['scheduler']       = 'rr'
default['kubernetes']['proxy']['ipvs']['strict_arp']      = false
default['kubernetes']['proxy']['ipvs']['sync_period']     = '30s'
default['kubernetes']['proxy']['ipvs']['tcp_fin_timeout'] = '0s'
default['kubernetes']['proxy']['ipvs']['tcp_timeout']     = '0s'
default['kubernetes']['proxy']['ipvs']['udp_timeout']     = '0s'

default['kubernetes']['proxy']['client_connection']['accept_content_types'] = ''
default['kubernetes']['proxy']['client_connection']['burst']                = 10
default['kubernetes']['proxy']['client_connection']['content_type']         = 'application/vnd.kubernetes.protobuf'
default['kubernetes']['proxy']['client_connection']['kubeconfig']           = '/etc/kubernetes/kube-proxy-kubeconfig.yaml'
default['kubernetes']['proxy']['client_connection']['qps']                  = 5
