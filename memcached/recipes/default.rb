#
# Cookbook Name:: memcached
# Recipe:: default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

version = node['memcached']['version']

#インストール
bash 'install memcached' do
  cwd '/tmp'
  not_if 'ls /tmp | grep "memcached-#{version}.tar.gz"'
  code <<-EOS
    wget http://memcached.org/files/memcached-#{version}.tar.gz
    tar -zxvf memcached-#{version}.tar.gz
    cd memcached-#{version}
    ./configure
    make
    make test
    make install
  EOS
end

#サービスに登録
template "/etc/init.d/memcached" do
  source "init.erb"
  mode 0700
  owner "root"
  group "root"
end

#サービス起動
service "memcached" do
  service_name "memcached"
  supports :start => true, :stop => true, :restart => true, :reload => true
  action [ :enable, :start ]
end