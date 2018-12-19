default['kubernetes']['addons']['dns']['controller']             = 'coredns'
default['kubernetes']['addons']['dns']['antiaffinity_type']      = 'preferredDuringSchedulingIgnoredDuringExecution'
default['kubernetes']['addons']['dns']['antiaffinity_weight']    = 100
default['kubernetes']['addons']['kubedns']['dns_forward_max']    = 150
default['kubernetes']['addons']['kubedns']['version']            = '1.14.10'
default['kubernetes']['addons']['kubedns']['limits']['cpu']      = '100m'
default['kubernetes']['addons']['kubedns']['limits']['memory']   = '170Mi'
default['kubernetes']['addons']['kubedns']['requests']['cpu']    = '100m'
default['kubernetes']['addons']['kubedns']['requests']['memory'] = '70Mi'
default['kubernetes']['addons']['coredns']['version']            = '1.3.0'
default['kubernetes']['addons']['coredns']['limits']['cpu']      = '100m'
default['kubernetes']['addons']['coredns']['limits']['memory']   = '256Mi'
default['kubernetes']['addons']['coredns']['requests']['cpu']    = '100m'
default['kubernetes']['addons']['coredns']['requests']['memory'] = '256Mi'
default['kubernetes']['addons']['coredns']['log']                = false
default['kubernetes']['addons']['coredns']['node_selector']      = false
default['kubernetes']['addons']['coredns']['hosts']              = []
default['kubernetes']['addons']['npd']['enabled']                = false
default['kubernetes']['addons']['npd']['version']                = '0.5.0'
default['kubernetes']['addons']['npd']['address']                = '0.0.0.0'
default['kubernetes']['addons']['npd']['port']                   = 20256
default['kubernetes']['addons']['npd']['log_level']              = 0
default['kubernetes']['addons']['npd']['system_log_monitors']    = %w(
/config/kernel-monitor.json
/config/kernel-monitor-filelog.json
/config/docker-monitor.json
/config/docker-monitor-filelog.json
)
