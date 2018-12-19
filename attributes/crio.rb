default['kubernetes']['crio']['version']                     = '1.12.3'
default['kubernetes']['crio']['endpoint']                    = '/var/run/crio/crio.sock'
default['kubernetes']['crio']['endpoint_proto']              = ''
default['kubernetes']['buildah']['version']                  = '1.5'
default['kubernetes']['libpod']['version']                   = '0.12.1.2'
default['kubernetes']['skopeo']['version']                   = '0.1.33'

default['kubernetes']['checksums']['skopeo']['bionic']       = 'd4a2213dce52d8acee0fd3386cd98a131f2a29f2ea484a3389c446bfe3208b16'
default['kubernetes']['checksums']['podman']['bionic']       = 'f90123bcac765713f90c4e669fa73cc0627908f774e5c207e9b4487c9439d9df'
default['kubernetes']['checksums']['conmon']['bionic']       = '06eafc61f08a9e450459f30c048c8ab936316377a4e94656f5f806ba483d376d'
default['kubernetes']['checksums']['crio']['bionic']         = '2bbba9c3e4eed3ca426b6aa4d71c9b86db0ca50656737a2b85812b9aa387a641'
default['kubernetes']['checksums']['buildah']['bionic']      = '5bfe90f4363e0f6ccb30030fcd4f3332f6591d9fd2d35066905d561a7089217e'

default['kubernetes']['checksums']['skopeo']['xenial']       = 'f6c3427f4f39cd323f25eedc3bae3fdec523bb77f58a00acaec8897a40ad8a81'
default['kubernetes']['checksums']['podman']['xenial']       = '472837d63cf3690382421e694b01d60c98ecaac1a4bf6c93bba3a64893ac616c'
default['kubernetes']['checksums']['conmon']['xenial']       = 'fd6c601a9fab8367c6ed3b86023444dba2287a5616f7014aa0020eac45532b6d'
default['kubernetes']['checksums']['crio']['xenial']         = 'a6e698bf45dabc6154e4a9720f8f0ebaa31ebf7ff233ded519630bb63ddf74a5'
default['kubernetes']['checksums']['buildah']['xenial']      = '6201c7e75d24489363b88d1132539e2fd3b2bb7f0b93b19770e12d7d19bcfde8'

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
