default['kubernetes']['crio']['version']                     = '1.15.0'
default['kubernetes']['crio']['endpoint']                    = '/var/run/crio/crio.sock'
default['kubernetes']['crio']['endpoint_proto']              = ''
default['kubernetes']['buildah']['version']                  = '1.9.2'
default['kubernetes']['libpod']['version']                   = '1.4.4'
default['kubernetes']['skopeo']['version']                   = '0.1.37'

default['kubernetes']['checksums']['skopeo']['bionic']       = '3e37fd8760fa183416d14de3e4c02da2cd8436db5d7e387c5077f30f5f681f32'
default['kubernetes']['checksums']['podman']['bionic']       = '683202cb21346ad115f4f911730a258d21dc95f032b41ce8756a16105d60c9be'
default['kubernetes']['checksums']['conmon']['bionic']       = '66caa33cb1e0d28dd55c3bf49a207ce489c59bd4f94aebab68f7376b46443d09'
default['kubernetes']['checksums']['crio']['bionic']         = '6f2335470e1e5357e3d2df305de98ba2b0c1f00710549da68a0957d010ae23e1'
default['kubernetes']['checksums']['buildah']['bionic']      = '2a0bbb4a59cb608987dd4ba39256f610210ef09263f6cf7993846499ede180f5'

default['kubernetes']['checksums']['skopeo']['xenial']       = '76dd2080aabd2d57838b219616d2bb1e431071f184ef33fb64a990df4e6194a8'
default['kubernetes']['checksums']['podman']['xenial']       = '05f5ae4c831f3752d7d6f8e904b99028766cd3cb71d581793d7693f862ca1400'
default['kubernetes']['checksums']['conmon']['xenial']       = '05e4618cd5bab745b2aa6a201e201ad3c6cfd05af279119101deaf5879dbc903'
default['kubernetes']['checksums']['crio']['xenial']         = '06d0e6b485b7f361bd89c91be59665f0ba25837d820de572f9295dbe37f10f36'
default['kubernetes']['checksums']['buildah']['xenial']      = '18fd11a5f9d46980b3605bde3a3cff68c48fbf7d3f58ca2a2e11e6cde103a444'

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
