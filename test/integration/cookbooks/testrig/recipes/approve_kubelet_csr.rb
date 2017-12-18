
# Approve pending CSR for local kubelet.
ruby_block 'approve local kubelet CSR' do
  block do
    get_csr_name_cmd = Mixlib::ShellOut.new("/usr/local/bin/kubectl get csr -o jsonpath='{.items[0].metadata.name}'")
    get_csr_name_cmd.run_command
    csr_name = get_csr_name_cmd.stdout

    approve_cmd = Mixlib::ShellOut.new("/usr/local/bin/kubectl certificate approve #{csr_name}")
    approve_cmd.run_command
  end
end
