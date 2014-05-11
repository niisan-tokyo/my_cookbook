

dir_name = node['php']['env_root'] + node['php']['version'] + '/etc/conf.d/'

bash 'install pecl mongo' do
  cwd '/tmp'
  not_if 'php -i | grep memcache'
  code <<-EOS
    pecl install mongo
    echo "extension=mongo.so" > #{dir_name}memcache.ini
  EOS
end