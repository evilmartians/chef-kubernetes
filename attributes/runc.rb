default['kubernetes']['runc']['version']      = '1.0.0-rc7'
default['kubernetes']['runc']['checksum']     = '633e1781f5d6f88fb338b4a59a6b6e969972e970677976570cc2c56c58e5a4cd'
default['kubernetes']['runc']['storage_url']  = "https://github.com/opencontainers/runc/releases/download/v%{version}/runc.amd64"
default['kubernetes']['runsc']['version']     = '2019-03-28'
default['kubernetes']['runsc']['storage_url'] = 'https://storage.googleapis.com/gvisor/releases/nightly/%{version}/runsc'
default['kubernetes']['runsc']['checksum']    = 'ea42ab0de0f6b9ba835881d9a3d25f9586cdd6ab2739c665d3d6c1d7a2eb890a'
