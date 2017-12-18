
describe command('etcdctl cluster-health') do
  its('stdout') { should match(/cluster is healthy/) }
end
