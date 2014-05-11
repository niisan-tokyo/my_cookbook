default['mysql']['version'] = '5.6'
default['mysql']['minor_version'] = '17'

default['mysql']['packages'] = %w{
  shared-compat
  server
  client
  devel
  shared
}
