#
# Cookbook Name:: php
# Recipe:: default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
# phpenvとphp-buildで任意バージョンのphpを試す
#

version = node['php']['version']
dir_name     = node['php']['env_root']

#phpenvインストール
bash 'install_phpenv' do
  not_if "ls #{dir_name}"
  user 'root'
  cwd '/tmp'
  code <<-EOH
    export PHPENV_ROOT=#{dir_name}
    wget https://raw.github.com/CHH/phpenv/master/bin/phpenv-install.sh
    bash phpenv-install.sh
    echo 'export PATH="#{dir_name}/bin:$PATH"' >> $HOME/.bashrc
    echo 'eval "$(phpenv init -)"' >> $HOME/.bashrc
    mkdir #{dir_name}/plugins
  EOH
end

#php-build をプラグインとしてインストール
git "#{dir_name}/plugins/php-build" do
  repository 'git://github.com/CHH/php-build.git'
  reference 'master'
  action :sync
  user 'root'
end

#ビルド時のconfigureオプション
cookbook_file "#{dir_name}/plugins/php-build/share/php-build/default_configure_options" do
  not_if "php -v | grep #{version}"
  owner 'root'
  group 'root'
  mode '0644'
  source 'default_configure_options.txt'
end

#インストールする
bash 'install_php' do
  not_if "php -v | grep #{version}"
  code <<-EOL
    source /root/.bashrc
    phpenv install #{version}
    phpenv rehash
    phpenv global #{version}
  EOL
end