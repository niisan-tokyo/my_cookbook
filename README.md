My Cookbooks for Vagrant!!
==========================

vagrant + VirtualBox で Nginx + php-fpm で動作する開発環境を簡単にさくせできるようにしたもの  
ついでに入れてるのは MySQL, Memcached, Redis  
フレームワークとして今流行のPhalconを突っ込んでみた

#使用条件

* VirtualBox
* Vagrant
    * plugin として vagrant-omnibus を導入しておこう
    
これらが入った状態で CentOS6.5のボックステンプレートをWeb上から落とす  
`vagrant box add centos65_min https://github.com/2creatives/vagrant-centos/releases/download/v6.5.1/centos65-x86_64-20131205.box`
どのボックスを取ってくるかはhttp://www.vagrantbox.es/ から探すといい

#環境の作成

適当なディレクトリで  
`vagrant init centos65_min`

次いで、そのディレクトリに、このmy_cookbooksをそのまま入れる  

この状態でコマンドラインで以下のコマンドを打てば環境が作成される  

`vagrant up`

Macであれば`vagrant ssh`でつなぐことができるが、Windowsの場合はSSHクライアントを導入して、ポート2222につなごう

いい感じに仕上がっていれば環境作成終了

#TODO

attributeとか全然使ってない。設定に追い出せるものは追い出したほうがいいかも