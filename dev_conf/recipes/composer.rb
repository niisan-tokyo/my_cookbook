#
# Cookbook Name:: dev_conf
# Recipe:: default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

#コンポーザーをインストールし直す
bash 'install dev composer' do
  cwd '/vagrant'
  code <<-EOS
    rm -f composer.*
    curl -sS https://getcomposer.org/installer | php
  EOS
end

#設定ファイルを突っ込む
cookbook_file '/vagrant/composer.json' do
  owner 'root'
  group 'root'
  mode '0644'
  source 'composer.json'
end

#コンポーザーで入れる
bash 'install dev composer' do
  cwd '/vagrant'
  code <<-EOS
    php composer.phar install
  EOS
end

#各々コマンドを入れる
%w{ phpcpd phpcs phpmd phpunit phpdoc }.each do |php_com|
  execute php_com do
    command "ln -s /vagrant/vender/bin/#{php_com} /usr/local/bin/#{php_com}"
  end
end