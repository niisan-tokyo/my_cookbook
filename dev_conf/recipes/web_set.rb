#
# Cookbook Name:: dev_conf
# Recipe:: web_set
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

php_path = node['php']['env_root'] + '/versions/' + node['php']['version'] + '/'
php_fpm_conf_path = php_path + node['php-fpm']['php_fpm_conf_name']

template "#{php_fpm_conf_path}" do
  owner 'root'
  group 'root'
  mode '0644'
  source 'php-fpm_conf.erb'

  variables ({
    :path   => php_path,
    :listen => node['php-fpm']['listen'],
    :user   => node['php-fpm']['user'],
    :group  => node['php-fpm']['group'],
    :timezone => node['web_set']['timezone']
  })
end

template "/etc/nginx/conf.d/default.conf" do
  source "nginx.erb"
  mode 0644
  owner "root"
  group "root"
  
  variables ({
    :root_path   => node['web_set']['webroot'],
    :listen => node['php-fpm']['listen']
  })
end

service 'php-fpm' do
  only_if 'ls /etc/init.d/php-fpm'
  action [ :enable, :restart ]
end

#スタート
service 'nginx' do
  action [ :enable, :start ]
end