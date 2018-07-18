default['kubernetes']['crio']['version']                     = '1.11.1'
default['kubernetes']['crio']['endpoint']                    = '/var/run/crio/crio.sock'
default['kubernetes']['crio']['endpoint_proto']              = 'unix://'
default['kubernetes']['buildah']['version']                  = '1.1'
default['kubernetes']['libpod']['version']                   = '0.7.2'
default['kubernetes']['skopeo']['version']                   = '0.1.30'

default['kubernetes']['checksums']['skopeo']['bionic']       = 'ab58c0bba0db5aebb0a51554d8c56d394fcb947ace652095335d1ae3f2905764'
default['kubernetes']['checksums']['podman']['bionic']       = '2cdd325bc00653f447a464ae312ebc005fc3706e8f440286c1eddf071446fe70'
default['kubernetes']['checksums']['conmon']['bionic']       = 'df2b674cd5e4d73309a6bf9ffd7d0b8f193fc915183cfe92a7a88233f1fa0ead'
default['kubernetes']['checksums']['crio']['bionic']         = '6a4eb5fa6a424f0d163d994d37b6f8b98536422b83495f8bbefd5e89aa608a7c'
default['kubernetes']['checksums']['buildah']['bionic']      = 'a0fa973a5b2cca3dc7e0716e750bf034cea04a77a1a7101a0e08e43a09f81526'

default['kubernetes']['checksums']['skopeo']['xenial']       = '9170c1128e0e20e1f39f440f8dc38a4b30ca6ca2131661f97ca50f0a0e7ca709'
default['kubernetes']['checksums']['podman']['xenial']       = '15ba045a391c578ea66c385873cd6ec73112386f5d36c1ac20423937f28c1d8d'
default['kubernetes']['checksums']['conmon']['xenial']       = '7a3155a460c7ac2adbc42427e9d20b3052c086dbb730fa59c1f59f088da2e034'
default['kubernetes']['checksums']['crio']['xenial']         = '6308161a5bd6cb1737159fb603744411681b0d2e558b709c1e09e3435875916d'
default['kubernetes']['checksums']['buildah']['xenial']      = 'e5b597e90ccd3594d4c07b96121abf941eefb705fcde3921d992a96e1b43b8c0'

default['kubernetes']['crio']['config']['runtime']           = '/usr/local/bin/runc'
default['kubernetes']['crio']['config']['untrusted_runtime'] = '/usr/local/bin/runsc'
default['kubernetes']['crio']['config']['conmon']            = '/usr/local/bin/conmon'
default['kubernetes']['crio']['config']['storage_driver']    = 'aufs'
default['kubernetes']['crio']['config']['stream_port']       = 10010
default['kubernetes']['crio']['config']['runroot']           = '/var/run/containers/storage'
default['kubernetes']['crio']['config']['root']              = '/var/lib/containers/storage'

default['kubernetes']['crio']['config']['runtime']           = '/usr/local/bin/runc'
default['kubernetes']['crio']['config']['untrusted_runtime'] = '/usr/local/bin/runsc'
default['kubernetes']['crio']['config']['conmon']            = '/usr/local/bin/conmon'
default['kubernetes']['crio']['config']['storage_driver']    = 'aufs'
default['kubernetes']['crio']['config']['stream_port']       = 10010
default['kubernetes']['crio']['config']['runroot']           = '/var/run/containers/storage'
default['kubernetes']['crio']['config']['root']              = '/var/lib/containers/storage'

default['kubernetes']['crio']['daemon_flags']['log_format']     = 'text'
default['kubernetes']['crio']['daemon_flags']['log_level']      = 'info'
default['kubernetes']['crio']['daemon_flags']['profile']        = false
default['kubernetes']['crio']['daemon_flags']['enable_metrics'] = true
default['kubernetes']['crio']['daemon_flags']['metrics_port']   = 9090

default['kubernetes']['crio']['policies']['default'] = [{"type"=>"insecureAcceptAnything"}]
default['kubernetes']['crio']['policies']['transports']['docker-daemon'][''] = [{"type"=>"insecureAcceptAnything"}]

default['kubernetes']['crio']['crictl']['version'] = '1.11.0'
default['kubernetes']['crio']['crictl']['timeout'] = 10
default['kubernetes']['crio']['crictl']['debug']   = false

default['kubernetes']['limits']['nofile']['crio'] = 1048576
default['kubernetes']['limits']['nproc']['crio']  = 1048576
default['kubernetes']['limits']['core']['crio']   = 'infinity'
