default['kubernetes']['scheduler']['secure_port']   = 10259
default['kubernetes']['scheduler']['leader_elect']  = true
default['kubernetes']['scheduler']['feature_gates'] = node['kubernetes']['feature_gates']
default['kubernetes']['scheduler']['master']        = "http://127.0.0.1:#{node['kubernetes']['api']['insecure_port']}"
