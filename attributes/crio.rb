default['kubernetes']['crio']['version']                     = '1.13.1'
default['kubernetes']['crio']['endpoint']                    = '/var/run/crio/crio.sock'
default['kubernetes']['crio']['endpoint_proto']              = ''
default['kubernetes']['buildah']['version']                  = '1.7.1'
default['kubernetes']['libpod']['version']                   = '1.2.0'
default['kubernetes']['skopeo']['version']                   = '0.1.35'

default['kubernetes']['checksums']['skopeo']['bionic']       = '89cae23860e0b08999555f9e9236ea973270abcf424b4a15ce0e0a775e33f8ac'
default['kubernetes']['checksums']['podman']['bionic']       = '6cf14a3e4e334ca057981b0e4df208d8e922906379a0dab74c1d2ff0200895fd'
default['kubernetes']['checksums']['conmon']['bionic']       = '09791f1e3958c1b55de9968209deebb9499ea09bcc89b3965cc4d6bdad368d19'
default['kubernetes']['checksums']['crio']['bionic']         = 'a5aeb72450f79c843795e59789b34a456a3ae39323bd4cf879a5b5b7fcc7a748'
default['kubernetes']['checksums']['buildah']['bionic']      = 'b289588f6c3073b797b6683344f772becbe5686085335096cd47b5fd1d7d7bff'

default['kubernetes']['checksums']['skopeo']['xenial']       = '3b94edd39c7d875bfd5c11be867f99ee74e415dc944a4cf41a6c1429d913c4e1'
default['kubernetes']['checksums']['podman']['xenial']       = '7d16a9da7a976dab35c9244166e0c9393cd561514a44f5252466c72501f62757'
default['kubernetes']['checksums']['conmon']['xenial']       = 'bd55ed8e9b41c82e26d642fa075ecf0fcf16b61352a1044656825c9c5bb7b487'
default['kubernetes']['checksums']['crio']['xenial']         = 'daa43e8193bec191368ba46319117f83ba40fae67ae61f933fb3f7d7cb8b372d'
default['kubernetes']['checksums']['buildah']['xenial']      = '36a92aebecfdc3eb282f6fc8d7aa003031fa4e30f7a980f62dfeaba64f6075d0'

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
