default['kubernetes']['crio']['version']                     = '1.14.5'
default['kubernetes']['crio']['endpoint']                    = '/var/run/crio/crio.sock'
default['kubernetes']['crio']['endpoint_proto']              = ''
default['kubernetes']['buildah']['version']                  = '1.8.4'
default['kubernetes']['libpod']['version']                   = '1.4.3'
default['kubernetes']['skopeo']['version']                   = '0.1.37'

default['kubernetes']['checksums']['skopeo']['bionic']       = '3e37fd8760fa183416d14de3e4c02da2cd8436db5d7e387c5077f30f5f681f32'
default['kubernetes']['checksums']['podman']['bionic']       = '9c4e6e1df78b2399d7ffa76f4a7eff7262e6f125c7c1d9880e3e43419b23dc74'
default['kubernetes']['checksums']['conmon']['bionic']       = 'be2e0ad0a2e31d151ac9a9bf1f253763e4ca0c9775835d20f49732d9fedb234a'
default['kubernetes']['checksums']['crio']['bionic']         = 'ff2268d3e1ee6ae4dbabe9927c0118fce50f8f9f353636c60cdd4e8a3db61de0'
default['kubernetes']['checksums']['buildah']['bionic']      = 'bcec52628c4a76d53552dc1d24b2bc2327fb3c18d29bded4a5e933f40a191e34'

default['kubernetes']['checksums']['skopeo']['xenial']       = '76dd2080aabd2d57838b219616d2bb1e431071f184ef33fb64a990df4e6194a8'
default['kubernetes']['checksums']['podman']['xenial']       = '5221a3ba0501f495deda3b27b56f526d72d9ee92ff8dd11504cb24083b66cf01'
default['kubernetes']['checksums']['conmon']['xenial']       = 'a9e9aedc1fe5ed5dc01de6df8f7553ec510646fd22bcf277157a4e555c53a307'
default['kubernetes']['checksums']['crio']['xenial']         = '49f9d571e71fde27ae941b5c02fabffbe9c96f0ffe11e3eab2a4efc77cd65e2d'
default['kubernetes']['checksums']['buildah']['xenial']      = '5275cc94956713f0c0394ec8cd9bac42c4e6838ee35020c161e4ec8c4e5d0312'

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
