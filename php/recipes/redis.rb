

dir_name = node['php']['env_root'] + '/versions/' + node['php']['version'] + '/etc/conf.d/'

bash 'install pecl redis' do
  cwd '/tmp'
  not_if 'php -i | grep "Redis Version"'
  code <<-EOS
    pecl install redis
    echo "extension=redis.so" > #{dir_name}redis.ini
  EOS
end