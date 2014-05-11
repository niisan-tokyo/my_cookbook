#
# Cookbook Name:: php
# Recipe:: fpm
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
# phpenv内でのphp-fpmを起動させる
#

php_path = node['php']['env_root'] + '/versions/' + node['php']['version'] + '/'
php_fpm_conf_path = php_path + node['php-fpm']['php_fpm_conf_name']
php_fpm_bin_path = php_path + node['php-fpm']['php_fpm_bin_path']

template "#{php_fpm_conf_path}" do
  owner 'root'
  group 'root'
  mode '0644'
  source 'conf.erb'

  variables ({
    :path   => php_path,
    :listen => node['php-fpm']['listen'],
    :user   => node['php-fpm']['user'],
    :group  => node['php-fpm']['group']
  })
end

template "/etc/init.d/php-fpm" do
  owner 'root'
  group 'root'
  mode '0744'
  source 'php-fpm.erb'

  variables ({
    :bin  => php_fpm_bin_path,
    :conf => php_fpm_conf_path
  })
end

directory "#{php_path}www" do
  owner 'root'
  group 'root'
  mode 00755
  action :create
end

service 'php-fpm' do
  only_if 'ls /etc/init.d/php-fpm'
  action [ :enable, :restart ]
end