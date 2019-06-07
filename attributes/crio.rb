default['kubernetes']['crio']['version']                     = '1.14.2'
default['kubernetes']['crio']['endpoint']                    = '/var/run/crio/crio.sock'
default['kubernetes']['crio']['endpoint_proto']              = ''
default['kubernetes']['buildah']['version']                  = '1.8.3'
default['kubernetes']['libpod']['version']                   = '1.3.2'
default['kubernetes']['skopeo']['version']                   = '0.1.36'

default['kubernetes']['checksums']['skopeo']['bionic']       = '59d9fb0cb687fe5882e643014d4324a1183035c6a3b3df7d225040817327bd75'
default['kubernetes']['checksums']['podman']['bionic']       = '78edf768c37d5b99007f6bf18047f5af140ceadc94560a801e0f3e72a2a76606'
default['kubernetes']['checksums']['conmon']['bionic']       = '7afcea7a8749b32a4def4ee2dc58a1cb1fceb3feff3631ce04d4b18aa2cab584'
default['kubernetes']['checksums']['crio']['bionic']         = 'f37561d4a1f21014e7795571dcee82aeb387cfb6d33ce867e82835ce03206d18'
default['kubernetes']['checksums']['buildah']['bionic']      = '4f2a64cb29927d4433a66f9fbf198d64234e4c58a3f7e321d65faa91ee2c1f1f'

default['kubernetes']['checksums']['skopeo']['xenial']       = '97772c2dd311c0e3d163045536f4713e6a84884c3841fada7fb7494bf8d4e521'
default['kubernetes']['checksums']['podman']['xenial']       = 'd2c055a1d7e81ce68139b240900d180923d821af1086d30a3f58b38773f137f8'
default['kubernetes']['checksums']['conmon']['xenial']       = 'a0b2ce16b15aac99374c5e062f08f7c2988adb0fecc4a309c326b7ffd4f78ff8'
default['kubernetes']['checksums']['crio']['xenial']         = '59597779f7bf63b2b0435adb5e4ef14c0db574802907b2db8cbde0560f87163a'
default['kubernetes']['checksums']['buildah']['xenial']      = '2f45b34b0b153c0430e238f8407e6cf9275aea2bf26dded6d63a1c2acdb26a5f'

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
