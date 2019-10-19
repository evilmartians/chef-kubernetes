default['kubernetes']['crio']['version']                     = '1.15.2'
default['kubernetes']['crio']['endpoint']                    = '/var/run/crio/crio.sock'
default['kubernetes']['crio']['endpoint_proto']              = ''
default['kubernetes']['buildah']['version']                  = '1.11.3'
default['kubernetes']['libpod']['version']                   = '1.6.2'
default['kubernetes']['skopeo']['version']                   = '0.1.39'

default['kubernetes']['checksums']['skopeo']['bionic']       = '79c473d5c522578da6a168063489e843b4180eaec2904b908c5784314cc3b55a'
default['kubernetes']['checksums']['podman']['bionic']       = '147fd54a5b559e2c9c1dd5ed2daa46139121ab81e2f42586031368860f27043d'
default['kubernetes']['checksums']['conmon']['bionic']       = '5bd6f228d372e1b1f7569d118919afc11a81f998f7f7469dd2eee50c3b675987'
default['kubernetes']['checksums']['crio']['bionic']         = '3f3bbeaaef33498ffa1d4fd6ea446013f93716e8762b86a40f0face3a162fa09'
default['kubernetes']['checksums']['buildah']['bionic']      = '33d815622e083008d31cb782f54dc479a3513fa7229a22e743746998b3930dcc'

default['kubernetes']['checksums']['skopeo']['xenial']       = '009082a890fceaa1badba7da254acc56e8d35466bcc62852481017eb03abbe68'
default['kubernetes']['checksums']['podman']['xenial']       = '16628b9532571fde2ee5f8f9be13fb9a884aa086e8c1ae844eedab8d64043f92'
default['kubernetes']['checksums']['conmon']['xenial']       = '6f3c870372646e76b47b3df82176d61a14905e75a429653b4edc34be8b7e2fd9'
default['kubernetes']['checksums']['crio']['xenial']         = '126066c23f2e0bc2886c25eb0dd81ceef41c892fb3c7d33fd97091c70bd51d71'
default['kubernetes']['checksums']['buildah']['xenial']      = '67cb534f66dd9bdfd9a0145508554445783def8bcc6f2487a389aeacc6a9c617'

default['kubernetes']['crio']['config']['conmon']            = '/usr/local/bin/conmon'
default['kubernetes']['crio']['config']['storage_driver']    = 'overlay'
default['kubernetes']['crio']['config']['stream_port']       = 10010
default['kubernetes']['crio']['config']['runroot']           = '/var/run/containers/storage'
default['kubernetes']['crio']['config']['root']              = '/var/lib/containers/storage'
default['kubernetes']['crio']['config']['log_level']         = 'info'
default['kubernetes']['crio']['config']['file_locking']      = false
default['kubernetes']['crio']['config']['file_locking_path'] = '/run/crio.lock'
default['kubernetes']['crio']['config']['cgroup_manager']    = 'cgroupfs'
default['kubernetes']['crio']['config']['apparmor_profile']  = 'crio-default'
default['kubernetes']['crio']['config']['seccomp_profile']   = '/etc/crio/seccomp.json'
default['kubernetes']['crio']['config']['pids_limit']        = 1024

default['kubernetes']['crio']['config']['runtimes'] = {
  'trusted'   => '/usr/local/bin/runc',
  'untrusted' => '/usr/local/bin/runsc'
}

default['kubernetes']['crio']['config']['runtimes']['untrusted']       = '/usr/local/bin/runsc'
default['kubernetes']['crio']['config']['container_exits_dir']         = '/var/run/crio/exits'
default['kubernetes']['crio']['config']['container_attach_socket_dir'] = '/var/run/crio'

default['kubernetes']['crio']['daemon_flags']['log_format']     = 'text'
default['kubernetes']['crio']['daemon_flags']['profile']        = false
default['kubernetes']['crio']['daemon_flags']['enable_metrics'] = true
default['kubernetes']['crio']['daemon_flags']['metrics_port']   = 9090

default['kubernetes']['crio']['policies']['default'] = [{"type"=>"insecureAcceptAnything"}]
default['kubernetes']['crio']['policies']['transports']['docker-daemon'][''] = [{"type"=>"insecureAcceptAnything"}]

default['kubernetes']['crio']['crictl']['version'] = '1.12.0'
default['kubernetes']['crio']['crictl']['timeout'] = 10
default['kubernetes']['crio']['crictl']['debug']   = false

default['kubernetes']['limits']['nofile']['crio'] = 1048576
default['kubernetes']['limits']['nproc']['crio']  = 1048576
default['kubernetes']['limits']['core']['crio']   = 'infinity'
