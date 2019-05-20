default['kubernetes']['crio']['version']                     = '1.14.1'
default['kubernetes']['crio']['endpoint']                    = '/var/run/crio/crio.sock'
default['kubernetes']['crio']['endpoint_proto']              = ''
default['kubernetes']['buildah']['version']                  = '1.7.3'
default['kubernetes']['libpod']['version']                   = '1.2.0'
default['kubernetes']['skopeo']['version']                   = '0.1.36'

default['kubernetes']['checksums']['skopeo']['bionic']       = '59d9fb0cb687fe5882e643014d4324a1183035c6a3b3df7d225040817327bd75'
default['kubernetes']['checksums']['podman']['bionic']       = '6cf14a3e4e334ca057981b0e4df208d8e922906379a0dab74c1d2ff0200895fd'
default['kubernetes']['checksums']['conmon']['bionic']       = '641dda91f92c8f2142ac509a2f186f6fa014456d00d388502b5609aed9ed18b8'
default['kubernetes']['checksums']['crio']['bionic']         = '78bf1bf1f146aef318ed5d4fa5386df8fec5f546c4e4ec8a78be6ce189393b3d'
default['kubernetes']['checksums']['buildah']['bionic']      = 'b84ca4afcd0563510e5c30be07219464997f3257eb9e5351bac6c1afd8dd764a'

default['kubernetes']['checksums']['skopeo']['xenial']       = '97772c2dd311c0e3d163045536f4713e6a84884c3841fada7fb7494bf8d4e521'
default['kubernetes']['checksums']['podman']['xenial']       = '7d16a9da7a976dab35c9244166e0c9393cd561514a44f5252466c72501f62757'
default['kubernetes']['checksums']['conmon']['xenial']       = 'd593e5317b5c71003bbd51d84e317e70f903b5c3bafe0d6ee1be247e407cf191'
default['kubernetes']['checksums']['crio']['xenial']         = '926cbb0f9363b1e2da6fc29b342a2bee468ce0eb1c84a9fb4e12c765f01ec699'
default['kubernetes']['checksums']['buildah']['xenial']      = 'fdfa31b438331a8f2ed96db8663deba82624d97f537f053955db86f213f11368'

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
