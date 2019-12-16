describe package('haproxy') do
  it { should be_installed }
  its('version') { should cmp >= '2.0' }
end

describe command('haproxy -c -V -f /etc/haproxy/haproxy.cfg') do
  its('exit_status') { should eq 0 }
end

describe systemd_service('haproxy') do
  it { should be_installed }
  it { should be_enabled }
  it { should be_running }
end
