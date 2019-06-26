default['kubernetes']['crio']['version']                     = '1.14.4'
default['kubernetes']['crio']['endpoint']                    = '/var/run/crio/crio.sock'
default['kubernetes']['crio']['endpoint_proto']              = ''
default['kubernetes']['buildah']['version']                  = '1.8.4'
default['kubernetes']['libpod']['version']                   = '1.3.2'
default['kubernetes']['skopeo']['version']                   = '0.1.36'

default['kubernetes']['checksums']['skopeo']['bionic']       = '59d9fb0cb687fe5882e643014d4324a1183035c6a3b3df7d225040817327bd75'
default['kubernetes']['checksums']['podman']['bionic']       = '78edf768c37d5b99007f6bf18047f5af140ceadc94560a801e0f3e72a2a76606'
default['kubernetes']['checksums']['conmon']['bionic']       = '278a276e10963a1dd190348ee451acb937589c33bd9d8be7490abb108d735906'
default['kubernetes']['checksums']['crio']['bionic']         = 'fddd9ad19a7d4bc0b86435465edc4ed88d46a77be32b029b11db31cbe7247802'
default['kubernetes']['checksums']['buildah']['bionic']      = 'bcec52628c4a76d53552dc1d24b2bc2327fb3c18d29bded4a5e933f40a191e34'

default['kubernetes']['checksums']['skopeo']['xenial']       = '97772c2dd311c0e3d163045536f4713e6a84884c3841fada7fb7494bf8d4e521'
default['kubernetes']['checksums']['podman']['xenial']       = 'd2c055a1d7e81ce68139b240900d180923d821af1086d30a3f58b38773f137f8'
default['kubernetes']['checksums']['conmon']['xenial']       = '83824cbb54b2b73a89ef54a3cd083671fd9be7fef66be48249867abc6bc392a5'
default['kubernetes']['checksums']['crio']['xenial']         = 'b151a972883dcb22e4be31e0ade90680267885a072db918800317f55a153721d'
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
