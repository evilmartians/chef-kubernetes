default['kubernetes']['crio']['version']                     = '1.15.0'
default['kubernetes']['crio']['endpoint']                    = '/var/run/crio/crio.sock'
default['kubernetes']['crio']['endpoint_proto']              = ''
default['kubernetes']['buildah']['version']                  = '1.10.1'
default['kubernetes']['libpod']['version']                   = '1.5.0'
default['kubernetes']['skopeo']['version']                   = '0.1.39'

default['kubernetes']['checksums']['skopeo']['bionic']       = '79c473d5c522578da6a168063489e843b4180eaec2904b908c5784314cc3b55a'
default['kubernetes']['checksums']['podman']['bionic']       = '208ae3a117a826214d0a198637816c96b977c547b2a962d1ca8166480665c13b'
default['kubernetes']['checksums']['conmon']['bionic']       = '66caa33cb1e0d28dd55c3bf49a207ce489c59bd4f94aebab68f7376b46443d09'
default['kubernetes']['checksums']['crio']['bionic']         = '6f2335470e1e5357e3d2df305de98ba2b0c1f00710549da68a0957d010ae23e1'
default['kubernetes']['checksums']['buildah']['bionic']      = 'd60404cd0b96d4215bed5af7ee92d2b8913edb85a9b0b32e61989babdada0bf8'

default['kubernetes']['checksums']['skopeo']['xenial']       = '009082a890fceaa1badba7da254acc56e8d35466bcc62852481017eb03abbe68'
default['kubernetes']['checksums']['podman']['xenial']       = '0cfc9a945bdcb5beaf4cd237b1b68d38911061fc336c9c9e57fcb5c76050b81f'
default['kubernetes']['checksums']['conmon']['xenial']       = '05e4618cd5bab745b2aa6a201e201ad3c6cfd05af279119101deaf5879dbc903'
default['kubernetes']['checksums']['crio']['xenial']         = '06d0e6b485b7f361bd89c91be59665f0ba25837d820de572f9295dbe37f10f36'
default['kubernetes']['checksums']['buildah']['xenial']      = '4e861588b1c8844bf4d42af9d9748741b768fad54273acf24d4933802787f50a'

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
