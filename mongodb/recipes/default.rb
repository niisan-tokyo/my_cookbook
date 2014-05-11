#
# Cookbook Name:: mongodb
# Recipe:: default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

version = node['mongodb']['version']

template "/etc/yum.repos.d/mongodb.repo" do
  source "repos.erb"
  mode 0644
  owner "root"
  group "root"
end

#Mongoインストール
node['mongodb']['packs'].each do |item|
  package item do
    action :install
  end
end

#起動
service "mongod" do
  service_name "mongod"
  supports :start => true, :stop => true, :restart => true, :reload => true
  action [ :enable, :start ]
end