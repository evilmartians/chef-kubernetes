default['kubernetes']['crio']['version']                     = '1.13.4'
default['kubernetes']['crio']['endpoint']                    = '/var/run/crio/crio.sock'
default['kubernetes']['crio']['endpoint_proto']              = ''
default['kubernetes']['buildah']['version']                  = '1.7.1'
default['kubernetes']['libpod']['version']                   = '1.2.0'
default['kubernetes']['skopeo']['version']                   = '0.1.35'

default['kubernetes']['checksums']['skopeo']['bionic']       = '89cae23860e0b08999555f9e9236ea973270abcf424b4a15ce0e0a775e33f8ac'
default['kubernetes']['checksums']['podman']['bionic']       = '6cf14a3e4e334ca057981b0e4df208d8e922906379a0dab74c1d2ff0200895fd'
default['kubernetes']['checksums']['conmon']['bionic']       = '6de5bf7310c25d13ebe97f48ff902a85bf2830999aa61faa76c290be75b5b592'
default['kubernetes']['checksums']['crio']['bionic']         = '37c6f48f825ec8684a8f6b4f1908c9e1557b10e0a21f48b2654a9a7cb8275613'
default['kubernetes']['checksums']['buildah']['bionic']      = 'b289588f6c3073b797b6683344f772becbe5686085335096cd47b5fd1d7d7bff'

default['kubernetes']['checksums']['skopeo']['xenial']       = '3b94edd39c7d875bfd5c11be867f99ee74e415dc944a4cf41a6c1429d913c4e1'
default['kubernetes']['checksums']['podman']['xenial']       = '7d16a9da7a976dab35c9244166e0c9393cd561514a44f5252466c72501f62757'
default['kubernetes']['checksums']['conmon']['xenial']       = 'e8016bf8fcbaf1faeb7c98fce375993068b601799d787a803a4713429d635809'
default['kubernetes']['checksums']['crio']['xenial']         = 'c7c7f28ab844740d77d05c21d7c78cb81276f5c81957808d59698fbf1f12ebb4'
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
