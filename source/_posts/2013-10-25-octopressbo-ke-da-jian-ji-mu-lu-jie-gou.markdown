---
layout: post
title: "Octopress博客搭建及目录结构"
date: 2013-10-25 11:49
comments: true
categories: Octopress
tags: [octopress, 博客]
keywords: octopress, linux, blog, ruby
description:
---
搭建个人博客的想法有一段时间了，不是认为自己有多牛，而是想通过写博客记录并反
思自己的学习历程，能使学过的东西更具条理，慢慢形成自己的知识体系。但自己租个
服务器，买个域名，一点一点搭建一个网站成本又太大，我对HTML、javascript、css
等前端技术了解有限，网站搭建很多技术也知之甚少。但后来Jekyll、Octopress、
GitHub pages让我搭建个人博客成为了可能。

最终选择了octopress，也是因为他的简单，他基于Jekyll，处理了Jekyll的很多麻烦
设置，也不需要对前端技术有很深的了解，从一开始什么也没有，到搭建起一个可用的
博客只需花费十几分钟，十分方便，虽然想要配置齐自己想要的东西还是需要一番折腾
的，但那是后话了。

我的搭建环境是ubuntu 13.04，不同的系统需要作出相应的修改，但变化不大。我的
博客中添加了3D标签、微博秀、豆瓣读书、相关文章推荐、访客地图、评论分享、
文章热度排名等等很多东西，本文主要介绍简单博客的搭建和目录结构，之后会写篇
文章介绍各个模块的搭建。
<!--more-->
## 开始搭建
Octopress博客是搭建在github上的静态网页，octopress相当于一个自动化生成静态网
页的工具，网页并没有使用数据库等，使用的是github提供的服务器和域名。github 
pages为每个用户提供一个名为`http://username.github.com`的域名。你首先需要
在github上建立一个名为`username.github.com`的仓库，之后的博客将会部署到这个
仓库中，部署成后你就可以从`http://username.github.com`访问你的博客了，不过
可能需要等待十分钟。

利用到了github，所以首先应该配置好你的git环境，包括安装git，创建ssh公私钥与
github建立信任连接，设置github用户名和邮箱，如果你不熟悉可以参考[GotGitHub](http://www.worldhello.net/gotgithub/index.html)。当然你还有熟悉git的基本操作了，[这里](http://rogerdudler.github.io/git-guide/index.zh.html)是一个简易教程。

octopress和jekyll都是依赖于Ruby的，所以如果你没装，先要装一下它咯。octopress
 2.0是依赖于Ruby 1.9.3版本的，所以我们指明版本安装：

	sudo apt-get install ruby1.9.3

接下来就可以安装Octopress了，首先将octopress库clone到本地，在想要放置本地仓
库的位置，建一个文件夹，文件夹名随你，比如我在$HOME/处建立了blog：
```
$ cd ~
$ mkdir blog
$ git clone git://github.com/imathis/octopress.git blog
```
然后进入仓库，安装其他的依赖环境：
```
$ cd blog
$ sudo gem install bundler
$ rbenv rehash
$ bundle install 		#根据Gemfile安装依赖的工具，需要耐心等待
```
安装默认主题

	rake install

现在octopress安装完成，但还没有生成静态网页，还没有将其部署到网上，要设置博客使用的REPOSITORY了：
```
$ rake setup_github_pages
Enter the read/write url for your repository
(For example, 'git@github.com:your_username/your_username.github.com')
Repository url:
```
请输入：git@github.com:yourname/yourname.github.com.git (将yourname替换成你的github登录名)

这个步骤rake会做很多事情：

1. 在.git/config中替换origin为你输入的repository，并把原来的origin写到octopress中。
2. 创建新的branch source并切换到这个branch。
3. 在生成的_deploy目录下，初始化git repository为你的repository。

接下来就可以生成静态网页，并将其部署到github上了，只需如下两句：
```
rake generate 	#生成静态网页
rake deploy 	#发布网页
```
等待几分钟后，网页就已经部署好了，你可以访问你的域名查看自己的博客了。然后可
以将源码添加到github中进行管理，你仓库中有两个分支，master分支是静态网页，
source分支则是你的生成网页的源码，这样在另一台电脑上你可以clone你的仓库，很
容易的进行你的博客编写。
```
git add .
git commit -m 'init'
git push origin source
```
现在就可以进行文章的编写了，编写文章使用markdown语法，十分便捷，语法简单，可
参见[markdown语法说明](http://wowubuntu.com/markdown/index.html#code)。
输入如下命令：

	rake new_post['title']

在~/blog/source/_posts下回生成一个名为`YYYY-MM-DD-title.markdown`的文件，在这个文件中编写你的文章即可。编写完成后依然按上边发布网页的方法发布即可：
```
rake generate 	#生成静态网页
rake deploy 	#发布网页
```
或者也可以生成静态网页后，在本机进行预览

	rake preview

然后可以通过`http://localhost:4000`访问，状态满意即可发布网页，以上几步同样适用于更改网页布局、样式等，重新发布网页。
## _config.yml
这是你的博客根目录下下的一个文件，通过编写它，可以设置网站基本信息，设置边栏
等：
```
url: http://812lcl.github.io 		#网站地址
title: 812lcl的博客 				#网站名
subtitle: 不要好高骛远，却又原地踏步；只想不做，太辜负青春了 	#网站副标题
author: 812lcl 						#作者名
lunr_search: false 					#lunr站内搜索，需要安装，麻烦
simple_search: http://google.com/search 	#默认搜索引擎
description: 						#网站描述
...
default_asides: [custom/asides/tag_cloud.html, asides/recent_posts.html, custom/asides/popular_posts.html...]
#边栏需要在这里添加路径
```
这个文件是很重要的配置文件，配置博客需要经常修改此文件。
## 目录结构
之所以要介绍目录结构，是为了更清晰的了解各个文件是做什么用的，修改网站样式
添加侧栏等等需要修改那些文件。以免按着教程一个一个设置完成，在脑子中却一团糟
不记得修改了什么，万一出现了错误就不好了。
```
├─ config.rb  #指定额外的compass插件
├─ config.ru  
├─ Rakefile   #rake的配置文件,类似于makefile
├─ Gemfile    #bundle要下载需要的gem依赖关系的指定文件
├─ Gemfile.lock  #这些gem依赖的对应关系,比如A的x本依赖于B的y版本
├─ _config.yml   #站点的配置文件
├─ public/   	#在静态编译完成后的目录,网站只需要这个目录下的文件树
├─ _deploy/  	#deploy时候生成的缓存文件夹,和public目录一样
├─ sass/  	#css文件的源文件,过程中会compass成css
├─ plugins/  	#放置自带以及第三方插件的目录,ruby程序
│  └── xxx.rb
└─ source/ 	#站点的源文件目录,public目录就是根据这个目录下数据生成的
   └─ _includes/
      └─ custom/  	#自定义的模板目录,被相应上级html include
         └─ asides/ 	#边栏模板自定义模板目录
      └─ asides/ 		#边栏模板目录
      └─ post/  		#文章页面相应模板目录
   └─ _layouts/  		#默认网站html相关文件,最底层
   └─ _posts/  		#新增以及从其它程序迁移过来的数据都存在这里
   └─ stylesheets/ 	#css文件目录
   └─ javascripts/  	#js文件目录
   └─ images/  		#图片目录
```

其中需要添加第三方插件时，将插件xxx.rb放入plugins文件夹中。最主要的文件夹是
source文件夹，因为修改网页都是在这个文件夹中进行。自己添加的边栏的HTML文件
都放置于`source/_includes/custom/asides`中，然后再_config.yml中的default_asides:中添加对应的路径，即可在网页上显示出边栏。
修改`source/_includes/`中的其他HTML文件，如header.html等，则可以修改标题栏、
导航栏、尾栏等等。

`source/_layouts`中则是网站的布局的一些HTML文件，可以修改文件布局等等。三个
文件夹目录是非常重要并且常修改的。source中images中则放置网站相关的一些图片，
javascripts文件家中放置一些模块需要调用的javascript脚本，_post中则是你的每篇
博客。

---
以上就是Octopress博客搭建的一个简单过程和目录结构，之后会详细介绍我的博客
中各个模块建立的过程及出现的问题，敬请关注。

参考文章：

- [利用Octopress在github Pages上搭建个人博客](http://easypi.github.io/blog/2013/01/05/using-octopress-to-setup-blog-on-github/)

- [迁移octpress,Rakefile修改以及豆瓣推荐,豆瓣收藏秀,新浪微博分享按钮等实现](http://www.dongwm.com/archives/qian-yi-octpressyi-ji-zi-ding-yi/)

- [Octopress博客设置](http://www.csdn123.com/html/blogs/20130531/17852.htm)
