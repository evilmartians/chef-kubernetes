default['kubernetes']['runc']['version']      = '1.0.0-rc6'
default['kubernetes']['runc']['checksum']     = '860dbff86558313caf23030f9638d1bcd7a43533f12227628f4abd678eef35c1'
default['kubernetes']['runc']['storage_url']  = "https://github.com/opencontainers/runc/releases/download/v%{version}/runc.amd64"
default['kubernetes']['runsc']['version']     = '2018-12-14'
default['kubernetes']['runsc']['storage_url'] = 'https://storage.googleapis.com/gvisor/releases/nightly/%{version}/runsc'
default['kubernetes']['runsc']['checksum']    = '65189851d1e68ddffc59989fb925b9069483f3fc86f35f2e74d4f1b100604950'
