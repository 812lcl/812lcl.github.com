---
layout: post
title: "多系统Linux安装及配置"
date: 2013-10-23 21:54
comments: true
categories: 磨刀利刃
tags: [ubuntu, linux, 装系统, 编程环境]
---
##1. 多系统安装
开始编程当然首先的任务是要配置好自己喜欢的编程环境，自从接触了linux，越来越
喜欢linux，先后使用过fedora、centos、ubuntu三个不同的版本。fedora还是比较炫
的，开始用了一段时间，但是由于一些原因之后开始使用内核版本更低的centos，并且
使用了较长一段时间。fedora和centos操作都是很像的，都是和redhat很接近的发行版
本，fedora内核版本更高，图形界面也更为华丽，但不如centos稳定。centos给我的
感觉就是朴实、稳定，但配置到我满意的状态也是需要一番功夫的，很多软件并不支持
centos，因为它的一些库版本较低，有些需要强制更新为更高版本才能用。而且学校的
校园网对国外的一些网站连不通，配置centos的源也比较麻烦，还需要添加很多不同的
第三方软件库，如EPEL源、RPMForge源、RPMFusion源、Rmei源。而且centos要挂载
<!-- more -->
ntfs的windows分区还需要安装ntfs-3g等，所以centos相对于其他版本，还是麻烦一些
，至少对我来说是的。现在我一般多用ubuntu了，这个系统很好安装很好上手。centos
的bin镜像要4G大小，刻进u盘里占用u盘过大空间，又不能用一次刻一次，所以常常
采用的方法是，从电脑上分出一个fat32的区，方centos镜像，然后用easyBCD简历grub
引导，开机引导到centos镜像进行安装。而ubuntu的镜像只有七八百兆，刻进u盘，都
都可以忽略它的存在，只要开机u盘启动即可进入安装了。这里也不讲具体如何安装了
，可以参考一下
[U盘安装Linux图解](http://blog.csdn.net/xiazdong/article/details/7523331)。
中间linux安装过程也不多讲了，安装提示一步一步来就好了。

注意装linux之前最好是先把要装linux的分区分出来。我最多在一台电脑上装了四个系
统：Win7、Win8、CentOS、Ubuntu。装多系统最好先windows后linux，先centos后
ubuntu。而且装多系统最好有一个u盘pe，防止装的过程出错，引导项没了，windows
也启动不起来。
##2. 更新软件源
ubuntu更新软件源很方便，已经收录了国内大部分知名的源，也不需上网查找，更改
`/etc/apt/sources.list`文件。

只需要打开软件中心->编辑->软件源，然后点击源的列表->其他站点

然后点选择最佳服务器，系统会根据你的网络状况，选择一个最快的源站点，最后选择
即可，非常方便。
##3. 安装喜欢的编辑器――VIM
我个人一般是习惯与使用有编辑器之神称号的vim，也是现在linu里都默认安装的编辑
器，十分的高效。当然其他还有emacs，smu等等，没怎么使用过，但也都是神级
编辑器。

vim有很多的插件，通过添加插件可以将原本就强大的vim，改装成近似IDE的样子。
我也会专门写一篇文章，记录我安装配置这些插件的过程。这些插件已经上传到我的
[GitHub](https://github.com/812lcl)中，就可以很快的还原我习惯的vim设置。当然
这之前需要先安装一些必备软件。包括gcc、g++编译器，java开发环境、vim插件ctags
和cscope。
```
sudo apt-get install gcc g++ git
sudo apt-get install build-essential
sudo apt-get install default-jre default-jdk
sudo apt-get install ctags cscope
```
必要的都安装完了，下面就是配置vim了，vim系统已经默认安装，ubuntu下也可以安装
图形界面版Gvim，在软件中心里就可以搜到，安装即可。然后执行如下命令
```
cd ~
git clone https://github.com/812lcl/vim.git
mv vim .vim
mv .vim/vimrc-lcl .vimrc
```
配置C/C++和java的只能补全
```
javac ~/.vim/autoload/Reflection.java
mv ~/.vim/autoload/Reflection.class ~
cd /usr/include/c++
ctags -R  然后在.vimrc中添加set tags+=/usr/include/c++/tags
```
以上就配置好了vim的一系列插件，可以查看配置文件`.vimrc`，或我的另一篇文章
[VIM插件配置，比肩IDE](http://812lcl.github.io/blog/2013/10/24/vimcha-jian-pei-zhi-%2Cbi-jian-ide/).
##4. 一些常用软件
当然linux也是离不开娱乐的，看电影、听歌还是要的。

- 听歌：自带的rhythm box播放器就可以了，但是缺少一些解码插件，打开一首歌，会自动寻找，统一安装即可。

- 看电影：我一般是安装smplayer，在软件中心里可以搜到，点点鼠标就OK了。

- 浏览器：linux都自带了firefox，但我还是习惯用chrome，软件中心里没有，去官网下一个deb包就可以了，`dpkg -i`安装。

- 虚拟机：有时候还是需要以下windows的，用个网银、MS office等等，装个虚拟机也是必要的，virtual box就搞定了，同样软件中心点一点。

- 其他：codeblocks、eclipse等，软件中心或是apt-get install即可。

##5. 更新
没有什么要设置的了，可以更新一下软件了。

	sudo apt-get update
##6. 其他
多系统可能需要修改一下启动顺序

	sudo vim /boot/grub/grub.cfg

其中有一句`default 0`，修改数字即可，如启动菜单第五项是windows，要默认启动
windows，改为`default 4`，保存的时候需要强制保存，输入`:wq!`

有时候想设置开机自动挂载windows分区

	sudo vim /etc/fstab

添加想开机挂载的分区即可
```sh
/dev/sda5 	/media/data 	ntfs 	defaults 	0 	0
挂载分区 	挂载位置 		分区类型
```
---
OK，流水账又记完了，主要是简单记录一下自己的linux环境配置，省得以后装系统再想还有哪些没装，Keep it simple and stupid.(KISS)
