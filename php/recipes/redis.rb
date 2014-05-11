

dir_name = node['php']['env_root'] + node['php']['version'] + '/etc/conf.d/'

bash 'install pecl redis' do
  cwd '/tmp'
  not_if 'php -i | grep redis'
  code <<-EOS
    pecl install redis
    echo "extension=redis.so" > #{dir_name}redis.ini
  EOS
end