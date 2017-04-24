default['kubernetes']['authorization']['admin_groups'] = ['admins']
default['kubernetes']['authorization']['mode']         = 'AlwaysAllow' # Available variants are: AlwaysAllow,AlwaysDeny,ABAC
default['kubernetes']['authorization']['policies']     = [
  { user:  '*',                                                                    nonResourcePath: '*', readonly: true },
  { user:  'admin',                  namespace: '*', resource: '*', apiGroup: '*' },
  { user:  'scheduler',              namespace: '*', resource: '*', apiGroup: '*' },
  { user:  'kubelet',                namespace: '*', resource: '*', apiGroup: '*' },
  { group: 'system:serviceaccounts', namespace: '*', resource: '*', apiGroup: '*', nonResourcePath: '*' }
]
