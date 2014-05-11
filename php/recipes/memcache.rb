

dir_name = node['php']['env_root'] + node['php']['version'] + '/etc/conf.d/'

bash 'install pecl memcached' do
  cwd '/tmp'
  not_if 'php -i | grep memcache'
  code <<-EOS
    pecl install memcache
    echo "extension=memcache.so" > #{dir_name}memcache.ini
  EOS
end