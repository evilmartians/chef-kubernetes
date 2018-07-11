default['kubernetes']['crio']['version']                     = '1.11.0'
default['kubernetes']['crio']['endpoint']                    = '/var/run/crio/crio.sock'
default['kubernetes']['crio']['endpoint_proto']              = 'unix://'
default['kubernetes']['buildah']['version']                  = '1.1'
default['kubernetes']['libpod']['version']                   = '0.7.1'
default['kubernetes']['skopeo']['version']                   = '0.1.30'

default['kubernetes']['checksums']['skopeo']['bionic']       = 'ab58c0bba0db5aebb0a51554d8c56d394fcb947ace652095335d1ae3f2905764'
default['kubernetes']['checksums']['podman']['bionic']       = 'e51df5725f36c168b5051decaf54c5517af878c5308d28c582407a4f9187c946'
default['kubernetes']['checksums']['conmon']['bionic']       = 'ffbed55f2c69dcc560bbc54b0e893b7ac2cbfea9b9487adcd96c3bfe6a68120c'
default['kubernetes']['checksums']['crio']['bionic']         = '0ae60656dc1b5383d826e39c2d13d54f43e6da5e58db5edd616a5a39bbba08aa'
default['kubernetes']['checksums']['buildah']['bionic']      = 'a0fa973a5b2cca3dc7e0716e750bf034cea04a77a1a7101a0e08e43a09f81526'

default['kubernetes']['checksums']['skopeo']['xenial']       = '9170c1128e0e20e1f39f440f8dc38a4b30ca6ca2131661f97ca50f0a0e7ca709'
default['kubernetes']['checksums']['podman']['xenial']       = 'cef7db9bae1615552fdd2cdbeac5ef485232a9103ec18dff072845bbd3f8269c'
default['kubernetes']['checksums']['conmon']['xenial']       = 'ffbed55f2c69dcc560bbc54b0e893b7ac2cbfea9b9487adcd96c3bfe6a68120c'
default['kubernetes']['checksums']['crio']['xenial']         = 'ed8a3a952db9be0f0b9c201756ab869a17699f1b0c54003cd2267c49bcf98714'
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
