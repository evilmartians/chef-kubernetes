default['kubernetes']['crio']['version']                     = '1.11.5'
default['kubernetes']['crio']['endpoint']                    = '/var/run/crio/crio.sock'
default['kubernetes']['crio']['endpoint_proto']              = 'unix://'
default['kubernetes']['buildah']['version']                  = '1.3'
default['kubernetes']['libpod']['version']                   = '0.9.3'
default['kubernetes']['skopeo']['version']                   = '0.1.31'

default['kubernetes']['checksums']['skopeo']['bionic']       = 'f6be0f8da43129d7c13b9d69d470ff34ea2e016d1a484fadab2a0219c73797f1'
default['kubernetes']['checksums']['podman']['bionic']       = '70925933422b264f1df5c38e1733af8834aaf9c959b4764ad575992bb7d52151'
default['kubernetes']['checksums']['conmon']['bionic']       = 'b8f864db7a95dedc99032661e99c37b6716cc158fa3348ef581f9480624d55d3'
default['kubernetes']['checksums']['crio']['bionic']         = '067f4f388ef8e186ee36a77e0bbb6f3cc4f5f94780fee5ef5a6f439346289698'
default['kubernetes']['checksums']['buildah']['bionic']      = 'bbd16dee74e1eac148144e33c2880d4321de0a6732456f795255663e9581cbb7'

default['kubernetes']['checksums']['skopeo']['xenial']       = '2f5e480ecb368b41214035aa9882b5f3b1a0a72babff1448ae3f875582a34520'
default['kubernetes']['checksums']['podman']['xenial']       = '32b83c72563058416b64ab5bd3226f471b72ff84e5b6accd98372574dfa8f5e4'
default['kubernetes']['checksums']['conmon']['xenial']       = 'dc3d83ac0e12f2a43b02600ef83faffa2c367529b9fa17bf1d95e4d00f090b98'
default['kubernetes']['checksums']['crio']['xenial']         = '74669ef6ab333622c7328ebd5134624fddae24aafec671e01b1d65402ba730b9'
default['kubernetes']['checksums']['buildah']['xenial']      = 'f3fe005b3386b4c2f11270425c96f6841f52dbbeb75582ac4b78ce5fb3943ad0'

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
default['kubernetes']['crio']['config']['log_level']         = 'info'

default['kubernetes']['crio']['daemon_flags']['log_format']     = 'text'
default['kubernetes']['crio']['daemon_flags']['profile']        = false
default['kubernetes']['crio']['daemon_flags']['enable_metrics'] = true
default['kubernetes']['crio']['daemon_flags']['metrics_port']   = 9090

default['kubernetes']['crio']['policies']['default'] = [{"type"=>"insecureAcceptAnything"}]
default['kubernetes']['crio']['policies']['transports']['docker-daemon'][''] = [{"type"=>"insecureAcceptAnything"}]

default['kubernetes']['crio']['crictl']['version'] = '1.11.1'
default['kubernetes']['crio']['crictl']['timeout'] = 10
default['kubernetes']['crio']['crictl']['debug']   = false

default['kubernetes']['limits']['nofile']['crio'] = 1048576
default['kubernetes']['limits']['nproc']['crio']  = 1048576
default['kubernetes']['limits']['core']['crio']   = 'infinity'
