default['kubernetes']['crio']['version']                     = '1.15.2'
default['kubernetes']['crio']['endpoint']                    = '/var/run/crio/crio.sock'
default['kubernetes']['crio']['endpoint_proto']              = ''
default['kubernetes']['buildah']['version']                  = '1.11.6'
default['kubernetes']['libpod']['version']                   = '1.6.3'
default['kubernetes']['skopeo']['version']                   = '0.1.40'

default['kubernetes']['checksums']['skopeo']['bionic']       = '6c27a887e798fdf4d4cf37d84283794a698c9a9c5872d66941fcf7f69ec271a4'
default['kubernetes']['checksums']['podman']['bionic']       = '644fe2631289c4d529390d654a7b3dc0af8191cc8d2aa10e9e1ac1530a760415'
default['kubernetes']['checksums']['conmon']['bionic']       = '5bd6f228d372e1b1f7569d118919afc11a81f998f7f7469dd2eee50c3b675987'
default['kubernetes']['checksums']['crio']['bionic']         = '3f3bbeaaef33498ffa1d4fd6ea446013f93716e8762b86a40f0face3a162fa09'
default['kubernetes']['checksums']['buildah']['bionic']      = '48e7feb9543015b6874db0b9a6dee1035606709863d53ec06086cf17e113353d'

default['kubernetes']['checksums']['skopeo']['xenial']       = '8224cdb3620d5bcd8fee097c32d3263cd5a39df1196187a8eb734ff1b83a841b'
default['kubernetes']['checksums']['podman']['xenial']       = '8ed4409cd0bed40ea97d5942399e18d411578d9f935cb1c6435fd932ecbec9fa'
default['kubernetes']['checksums']['conmon']['xenial']       = '6f3c870372646e76b47b3df82176d61a14905e75a429653b4edc34be8b7e2fd9'
default['kubernetes']['checksums']['crio']['xenial']         = '126066c23f2e0bc2886c25eb0dd81ceef41c892fb3c7d33fd97091c70bd51d71'
default['kubernetes']['checksums']['buildah']['xenial']      = 'b84f70227696eb9d2070a97014a165e7225ff329e9bd9359caa658a0a32c8299'

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
