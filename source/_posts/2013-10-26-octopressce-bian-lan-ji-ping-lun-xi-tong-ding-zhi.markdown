---
layout: post
title: "Octopress侧边栏及评论系统定制"
date: 2013-10-26 22:36
comments: true
categories: Octopress
tags: [octopress, 博客, ruby, html]
---
在[上一篇文章](http://812lcl.github.io/blog/2013/10/25/octopressbo-ke-da-jian-ji-mu-lu-jie-gou/)中，已经搭建起了octopress博客。使用的是默认的主题，样式
千篇一律，而且自带的一些功能和侧边栏并不适合国内的国情，得不到网络的支持，
如facebook、twitter、google plus和disqus等。所以还是有必要进行一下改造，打造
中国特色octopress博客的。
## 1. 第三方主题
首先，你先要选定的是博客使用的第三方主题，因为如果你已经进行了很多的网页设置
，添加了很多的插件，再来改主题，你就要面临悲剧了，你会发现你已经配置好的东西
被替换掉了，这无疑会对你的热情带来打击。所以我们先来看看第三方主题。

你需要先找到自己喜欢的主题，之后可以在此主题上进行修改。
[点击这里](http://opthemes.com/)是一个主题网站，给出了不同主题的预览图，使用
该主题的博客和该主题的GitHub链接。选中你想要的，获得GitHub仓库地址，如下安装
```
$ cd blog
$ git clone https://github.com/shashankmehta/greyshade.git ./themes/greyshade
$ rake install['greyshade']
$ rake generate
```
这里我的博客在blog文件夹中，以安装greyshade主题为例。你按照自己的情况进行
更改。`rake generate`后可以通过`rake preview`访问`http://localhost:4000`
预览新的主题样式，不满意可以更换其他主题。
<!--more-->
## 2. 侧边栏
侧边栏可以添加的插件很多，新浪微博、豆瓣等很多网站都有相应的插件，也可以到
[octopress的wiki页面](https://github.com/imathis/octopress/wiki)寻找。

侧边栏在`_config.yml`中设置，添加进`default_asides`中，先后顺序代表显示的
先后顺序，各个侧边栏插件代码放入相应的位置即可，自己添加的一般放入`source/_includes/custom/asides`，`default_asides`中默认从`_includes`之后路径开始写。
### 2.1 最新文章
首先说一下主题中可用的插件。

`asides/recent_posts.html`是最近写的文章的一个
展示，添加到`default_asides`中即可显示，在`_config.yml`中可以设置显示最近
多少篇文章，`recent_posts: 5`，注意冒号后有空格。
### 2.2 GitHub Repos
`asides/github.html`则是GitHub repos的一个展示，可以直接到达你的GitHub页面，
在`_config.yml`中设置你的Github账号，并设置为`true`即可，如下：
```
# Github repositories
github_user: 812lcl 	#我的github
github_repo_count: 0
github_show_profile_link: true
github_skip_forks: true
```
### 2.3 微博秀
新浪微博是一个信息传播非常迅速的媒介，如果你热衷于微博，可以在侧边栏添加
自己的微博秀。首先需要获得自己的微博秀代码，链接为[http://app.weibo.com/tool/weiboshow](http://app.weibo.com/tool/weiboshow)，进行相应的设置即可获得微博秀代码。

然后在`source/_includes/custom/asides`创建weibo.html，添加如下代码，刚刚获得
的微博秀代码也要添加到相应位置：
```
<section>
    <h1>新浪微博</h1>
    <ul id="weibo">
    <li>

    <!-- 在此插入获得的微博秀代码 -->

      </li>
    </ul>
</section>

```
最后在`default_asides`中加入`custom/asides/weibo.html`即可显示你的微博秀了。
### 2.4 豆瓣展示
你可以通过豆瓣读书、豆瓣电影、豆瓣音乐等多方面展示你自己，豆瓣也提供了类似
微博秀的展示方式，添加方法也类似。获得豆瓣收藏秀的链接[http://www.douban.com/service/badgemakerjs](http://www.douban.com/service/badgemakerjs)，根据自己的喜欢进行设置

然后在`source/_includes/custom/asides`创建douban.html，添加如下代码，
刚刚获得的代码添加到`<div>`之间：
```
<section>
	<h1>My Douban</h1>
	<div>
	<!--添加到这-->
	</div>
</section>
```
最后在`default_asides`中加入`custom/asides/douban.html`显示你的豆瓣展示。
### 2.5 访客地图
效果如我的博客右侧那个精美的3D旋转地球所示，它可以显示访客数量，访客来自的
地域，既有装饰作用，又有统计作用。它也有2D效果版，可以根据自己喜欢进行设置，
地址在[这里](http://www.revolvermaps.com/?target=setup)，然后获得代码。

依然在`source/_includes/custom/asides`创建earth.html，代码如下：
```
<section>
	<h1>访客地图</h1>
	<!--获得代码添加到这-->
</section>

```
在`default_asides`中加入`custom/asides/earth.html`显示你定制的访客地图。
### 2.6 酷站博客
你有一些经常去的网站、博客，想推荐给大家，则可以在侧边栏加上一个“酷站博客”
，当然名字你自己取即可。

在`source/_includes/custom/asides`创建blog_link.html，代码如下：
```
<section>
<h1>酷站博客</h1>
<ul>
        <li>
        <a href="http://blog.jobbole.com/">伯乐在线</a>
        </li>
        <li>
        <a href="http://www.csdn.net/">CSDN</a>
        </li>
        <li>
        <a href="http://www.cnblogs.com/">博客园</a>
        </li>
        <li>
        <a href="http://coolshell.cn/">酷壳CoolShell</a>
        </li>
        <li>
        <a href="http://www.cnblogs.com/Solstice/">陈硕</a>
        </li>
</ul>
</section>
```
可以自行添加喜爱网站，然后在`default_asides`中加入`custom/asides/blog_link.html`。

看到这，你应该很熟悉添加侧边栏的流程了吧。
### 2.7 最热文章
Octopress Popular Posts Plugin是根据Google page rank计算，展示出权值最高的
文章，插件的项目主页为[点击这里](https://github.com/octopress-themes/popular-posts)。

这个插件的安装与之前的方法不同，首先在`Gemfile`中添加

	gem 'octopress-popular-posts'

`Gemfile`中的是bundle安装时安装的所有依赖的软件，然后用bundle安装

	bundle install

执行命令，将插件拷贝到你的source目录，如下：

	bundle exec octopress-popular-posts install

到这就安装完了，可以设置显示了，在`_config.yml`中设置，增加下面一行：

	popular_posts_count: 5      # Posts in the sidebar Popular Posts section

设置边栏显示文章数，最后在`default_asides`中添加`custom/asides/popular_posts.html`，即可显示出来。

这样就设置好了，同时建议将缓存的page rank文件添加进你的`.gitignore`中

	.page_rank

### 2.8 3D标签云与标签列表
octopress默认的只支持category的分类，而并没有tag。category和tag分别代表有序/
无序的知识点归纳。一篇文章只能属于一个category，但可以有多个tag。原来的
plugin下只有category_generator.rb插件，实现category功能，在github上有两个插件帮助实现了tag生成和tag cloud功能[插件1](https://github.com/robbyedwards/octopress-tag-pages)，[插件2](https://github.com/robbyedwards/octopress-tag-cloud)。
但似乎并不支持中文，而category_generator.rb是支持中文的，所以我有样学样，改
成了支持中文的，并且实现了3D标签云的，插件已经上传到[github](https://github.com/812lcl/category_tag)。clone到你博客的目录即可。

包含文件如下：
```
 ├─ plugins/
    │  ├─ category_generator.rb
    │  ├─ category_list.rb
    │  ├─ category_tag_cloud.rb
    │  ├─ tag_generator.rb
    │  └─ tag_list.rb
    └─ source/
       └─ _includes/
          └─ custom/
             └─ asides/
                ├─ category_cloud.html
                ├─ category_list.html
                ├─ tag_cloud.html
                └─ tag_list.html
```
其中`category_generator.rb`和`tag_generator.rb`定义了根据文章的category和tag
标签分类存储文章的方法，`category_tag_cloud.rb`则可以定义了根据category或tag
生成3D标签云的方法。`category_list.rb`和`tag_list.rb`实现了将所有文章的category和tag列出来的方法，其中category可以显示文章个数，tag根据此标签文章多少，
大小随着改变。

四个HTML文件则是category和tag的列表和3D标签云的侧边栏实现。需要哪个，在`default_asides`中添加即可。

还有一点需要注意，在_config.yml中默认设置了category的目录，需自己加入tag目录
```
category_dir: blog/categories
tag_dir: blog/tags
```
这样可以观看效果了，不过3D效果的标签云，对于不支持flash的浏览器无效，如`safari`。

标签功能的实现，我参考了一下几篇文章：

- [为octopress添加分类(category)列表](http://codemacro.com/2012/07/18/add-category-list-to-octopress/)

- [给 Octopress 加上标签功能](http://blog.log4d.com/2012/05/tag-cloud/)

- [给octopress添加3D标签云](http://guori12321.github.io/blog/2013/08/20/gei-octopresstian-jia-3dyun-biao-qian/)

### 2.9 相关文章功能
此功能即根据当前阅读的文章，分析博客中其他与此相近的文章，进行推荐的一个功能
，在octopress wiki中推荐的第三方插件中有一个插件实现此功能，项目主页[点击这里](https://github.com/jcftang/octopress-relatedposts)。该插件，利用octopress自带的LSI实现对文章分析分类，然后进行推荐，但当文章较多时分类过慢，它推荐
安装GSL来进行分类。我安装过这个功能，但不知道它是根据什么规则分类，而且之后
不知道安装了什么，之后每次分类都会出错。你可以自己尝试一下，项目主页都有
详细的步骤。

就在我想放弃这个功能的时候，我发现了它――[related_posts-jekyll_plugin](https://github.com/LawrenceWoodman/related_posts-jekyll_plugin)。
这个插件很简单，只需下载_plugins/related_posts.rb放在自己的plugins文件夹中，
然后在想添加相关文章推荐的地方添加如下语句：
```
<section>
	<h2>相关文章：</h2>
	<ul class="posts">
		 {% for post in site.related_posts limit:5 %}
			<li class="related">
			<a href="{{ root_url }}{{ post.url }}">{{ post.title }}</a>
			</li>
		{% endfor %}
	</ul>
 </section>
```
我是在source/_layouts/post.html中加入的这些语句，这个html文件是打开博文时
的布局，我将相关文章添加在博文的结束处。

这个插件是根据文章的tag进行分类的，根据所有博文与本篇文章共同tag的多少依次
排序进行推荐，还是很简单有效的。

参考[这里](http://techtinkering.com/2011/08/17/improving-related-posts-on-jekyll/)

## 3. 社会化评论与分享
### 3.1 友言和加网
octopress内置了disqus评论系统，不适合我国基本国情，所以需要用一些国内的第三
方评论系统，如友言、多说，可以以微博、人人、QQ等账号登陆发表评论，网站通过
验证后可以对评论进行分析，管理。

多说评论系统可参见[为 Octopress 添加多说评论系统](http://havee.me/internet/2013-02/add-duoshuo-commemt-system-into-octopress.html)，不多做介绍。

我主要使用的是友言的一套评论系统及插件，分享使用的是加网JiaThis。首先注册
[友言](http://www.uyan.cc/)账号，否则无法进行后台管理。注册之后获得代码，
添加到`source/_includes/post/share_comment.html`。
加网[点击这里](http://www.jiathis.com/getcode/icon)，定制自己喜欢的样式，
获得代码也添加到上述文件中。

share_comment.html文件中代码如下（每个人不同）：
```
<!-- JiaThis BEGIN -->
<div class="jiathis_style_32x32">
        <a class="jiathis_button_qzone"></a>
        <a class="jiathis_button_tsina"></a>
        <a class="jiathis_button_tqq"></a>
        <a class="jiathis_button_weixin"></a>
        <a class="jiathis_button_renren"></a>
        <a href="http://www.jiathis.com/share?uid=1850190" class="jiathis jiathis_txt jtico jtico_jiathis" target="_blank"></a>
        <a class="jiathis_counter_style"></a>
</div>
<script type="text/javascript" src="http://v3.jiathis.com/code/jia.js?uid=1361705530382241" charset="utf-8"></script>
<!-- JiaThis END -->

<!-- Baidu Button BEGIN 
<div id="bdshare" class="bdshare_t bds_tools_32 get-codes-bdshare">
        <a class="bds_tsina"></a>
        <a class="bds_qzone"></a>
        <a class="bds_tqq"></a>
        <a class="bds_renren"></a>
        <a class="bds_t163"></a>
        <a class="bds_hi"></a>
        <span class="bds_more"></span>
        <a class="shareCount"></a>
</div>
<script type="text/javascript" id="bdshare_js" data="type=tools&amp;uid=6839808" ></script>
<script type="text/javascript" id="bdshell_js"></script>
<script type="text/javascript">
        document.getElementById("bdshell_js").src = "http://bdimg.share.baidu.com/static/js/shell_v2.js?cdnversion=" + Math.ceil(new Date()/3600000)
</script>
 Baidu Button END -->

<!-- UY BEGIN -->
<div id="uyan_frame"></div>
<script type="text/javascript" src="http://v2.uyan.cc/code/uyan.js?uid=1850190"></script>
<!-- UY END -->
```
其中有一段代码注释掉了，那是我曾经添加的百度分享的代码，如果使用其他分享或
评论，代码也可以添加到这。

现在功能代码在share_comment.html中了，下面需要使其显示到博文的底部。

首先在_config.yml中添加开关：
```
# comment and share
comment_share: true
```
然后在`source/_includes/post/sharing.html`中添加如下代码：
```
{% if site.comment_share %}
  {% include post/share_comment.html %}
{% endif %}
```
最后需要使你的网站通过友言的验证，才可以进行后台管理，后台可以进行评论管理、
社交影响力分析、和评论栏的风格功能设置。

### 3.2 评论热榜和最新评论侧边栏
友言提供了多个嵌入式组件，如评论热榜、最新评论、评论计数等。我们可以将他们
做成侧边栏进行展示，或在首页文章列表中，显示每篇文章的评论数目。

首先在你的友言后台管理中找到`安装设置->嵌入式组件`获得评论热榜和最新评论的
代码，分别创建`source/_includes/custom/asides/uyan_hotcmt.html`和`source/_includes/custom/asides/uyan_newcmt.html`，代码如下：

``` 
<section>
<h1>评论热榜</h1>
<div id="uyan_hotcmt_unit"></div>
        <script type="text/javascript" src="http://v2.uyan.cc/code/uyan.js?uid=1850190"></script>
</section>
```

```
<section>
<h1>最新评论</h1>
<div id="uyan_newcmt_unit"></div>
        <script type="text/javascript" src="http://v2.uyan.cc/code/uyan.js?uid=1850190"></script>
</section>
```

然后再`_config.yml`的`default_asides`中添加其路径即可显示在侧边栏中。

友言评论框、评论热榜、最新评论可以在后台进行设置，改变设置并不需要更改代码。

### 3.3 评论计数显示
友言提供评论计数功能，可以将每篇文章的评论数显示在博客首页相应文章题目旁。
实现方法为：在`source/_includes/article.html`中
```
{% include post/date.html %}{{ time }}
```
的后边填入嵌入组件中获得的评论计数的代码，需要修改其中一些内容
```
 | <a href="{% if index %}{{ root_url }}{{ post.url }}{% endif %}#comments" id="uyan_count_unit" du="" su="">0条评论</a>
  <script type="text/javascript" src="http://v2.uyan.cc/code/uyan.js?uid=1850190"></script>
```

## 4. 为博文添加原文链接及声明
可以为你的每篇博文末尾加上原文链接，方法很简单，只需创建`plugins/post_footer_filter.rb`，代码如下：
```
# post_footer_filter.rb
# Append every post some footer infomation like original url 
# Kevin Lynx
# 7.26.2012
#
require './plugins/post_filters'

module AppendFooterFilter
        def append(post)
                author = post.site.config['author']
                url = post.site.config['url']
                pre = post.site.config['original_url_pre']
                post.content + %Q[<p class='post-footer'>
                        #{pre or "original link:"}<a href='#{post.full_url}'>#{post.full_url}</a><br/>&nbsp;written by <a href='#{url}'>#{author}</a>&nbsp;posted at <a href='#{url}'>#{url}</a></p>]
        end
end

module Jekyll
        class AppendFooter < PostFilter
                include AppendFooterFilter
                def pre_render(post)
                        post.content = append(post) if post.is_post?
                end
        end
end

Liquid::Template.register_filter AppendFooterFilter
```
并可以针对这一区域的样式进行美化，在`sass/custom/_style.scss`末尾增加下列内容：

	.post-footer{margin-top:10px;padding:5px;background:none repeat scroll 0pt 0pt #eee;font-size:90%;color:gray}

尊重原创，此功能来源[为octopress每篇文章添加一个文章信息](http://codemacro.com/2012/07/26/post-footer-plugin-for-octopress/)。

## 5. 公益404
在`source`目录下创建404.markdown，添加如下代码，即可实现公益404的功能，当你的网页出错找不到时，可以为公益尽一份力。
```
---
layout: page
title: "404 Error"
date: 2013-10-10 19:17
comments: false
sharing: false
footer: false
---
<script type="text/javascript" src="http://www.qq.com/404/search_children,js" charset="utf-8></script>
```

---
好了先写到这了，还有一些东西没写，等后续再写吧。

参考文章：

- [定制Octopress](http://biaobiaoqi.me/blog/2013/07/10/decorate-octopress/)

- [精美的3D旋转地球统计RevolverMaps](http://xuhehuan.com/141.html)
