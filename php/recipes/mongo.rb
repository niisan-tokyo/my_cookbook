

dir_name = node['php']['env_root'] + '/versions/' + node['php']['version'] + '/etc/conf.d/'

bash 'install pecl mongo' do
  cwd '/tmp'
  not_if 'php -i | grep mongo'
  code <<-EOS
    pecl install mongo
    echo "extension=mongo.so" > #{dir_name}mongo.ini
  EOS
end