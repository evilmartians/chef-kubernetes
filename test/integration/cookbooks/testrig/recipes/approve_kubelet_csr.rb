
# Approve pending CSR for local kubelet.
ruby_block 'approve local kubelet CSR' do
  block do
    get_csr_name_cmd = Mixlib::ShellOut.new("/usr/local/bin/kubectl get csr -o jsonpath='{.items[*].metadata.name}'")
    get_csr_name_cmd.run_command
    csr_name = get_csr_name_cmd.stdout.split(' ')

    csr_name.each do |csr|
      approve_cmd = Mixlib::ShellOut.new("/usr/local/bin/kubectl certificate approve #{csr}")
      approve_cmd.run_command
    end
  end
end
