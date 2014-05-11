#
# Cookbook Name:: mariadb
# Recipe:: default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

#設定ファイルの投入
cookbook_file '/etc/yum.repos.d/MariaDB.repo' do
  not_if "ls /etc/yum.repos.d/ | grep MariaDB.repo"
  owner 'root'
  group 'root'
  mode '0644'
  source 'init.rb'
end

%w{ MariaDB-server MariaDB-client }.each do |pack|
  package pack do
    action :install
  end
end

#起動
service "mysql" do
  service_name "mysql"
  supports :start => true, :stop => true, :restart => true, :reload => true
  action [ :enable, :start ]
end