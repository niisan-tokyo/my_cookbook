#
# Cookbook Name:: redis
# Recipe:: default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

version = node['redis']['version']

#インストール
bash 'install redis' do
  cwd '/tmp'
  not_if 'ls /tmp | grep "redis-#{version}.tar.gz"'
  code <<-EOS
    wget http://download.redis.io/releases/redis-#{version}.tar.gz
    tar -zxvf redis-#{version}.tar.gz
    cd redis-#{version}
    ./configure
    make
    make test
    make install
  EOS
end

template "/usr/local/src/redis.conf" do
  source "config.erb"
  mode 0644
  owner "root"
  group "root"
end

#サービスに登録
template "/etc/init.d/redis" do
  source "init.erb"
  mode 0700
  owner "root"
  group "root"
end

#サービス起動
service "redis" do
  service_name "redis"
  supports :start => true, :stop => true, :restart => true, :reload => true
  action [ :enable, :start ]
end