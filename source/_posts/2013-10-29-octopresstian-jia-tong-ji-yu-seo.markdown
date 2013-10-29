---
layout: post
title: "Octopress添加统计与SEO"
date: 2013-10-29 19:28
comments: true
categories: Octopress
tags: [octopress, 博客, SEO]
keywords: seo, octopress, analytics
description: 为Octopress添加统计工具，SEO技巧，语法高亮及站内搜索
---
博客建好了，文章写出来，当然希望有人能看到，而且希望更多的人看到，这就需要让
自己的博客可以在搜索引擎里面检索到，自己搭建的博客不像在CSDN、博客园写的文章
，因为你的博客还没有被提交到搜索引擎，让它来抓取你，所以首先要到各个搜索引擎
提交自己的博客地址。

http://urlc.cn/tool/addurl.html

http://tool.lusongsong.com/addurl.html

提交到搜索引擎了，能搜索到你的文章了，你还需要做的是为你的网站、文章添加描述
信息、关键字，来帮助用户准确的搜索到你的文章。关键字和描述是指网页head部分的
元标签meta，是给搜索引擎看的，以此希望用户可以比较容易找到。

<!-- more -->

首先为你的每篇文章添加描述和关键字，本文的文件头如下：

```
---
layout: post
title: "Octopress添加统计与SEO"
date: 2013-10-29 22:37
comments: true
categories: Octopress
tags: [octopress, 博客, SEO]
keywords: seo, octopress, analytics, 站内搜索
description: 为Octopress添加统计工具及SEO技巧
---
```

这样就可以为你的文章添加关键字和描述，使搜索引擎更容易搜到你的文章。你还可以
为你的博客首页添加描述和关键字，在`source/index.html`文件顶部添加即可，方法
如上。

如果你没有为文章添加描述，octopress会自动以文章的前150个字符作为描述，以为
每一篇文章都添加描述，octopress模板实现以上功能的代码在`source/_includes/head.html`中：
{% raw %}

``` html
{% capture description %}{% if page.description %}{{ page.description }}{% else %}{{ content | raw_content }}{% endif %}{% endcapture %}
  <meta name="description" content="{{ description | strip_html | condense_spaces | truncate:150 }}">
{% if page.keywords %}<meta name="keywords" content="{{ page.keywords }}">{% endif %}
```
{% endraw %}
此外，也可以在`_config.yml`里添加默认的`description`和`keywords`。

## 统计工具
octopress模板里面默认带了Google Analytics工具，只需要注册[Google Analytics]
(http://www.google.com/analytics/)，获得一个google_analytics_tracking_id，
添加到`_config.yml`中对应位置，并对网站进行验证即可。然后可以通过Google Analytics分析网站的流量了。而且可以使用[Google站长工具](https://www.google.com/webmasters/tools/home?hl=zh-CN)，对网站进行更全面的分析，进行SEO。

对自己的网站进行验证，只需将网站提供的用于验证的代码添加到`source/_includes/head.html`的`<head>`标签之间，网站部署到网上后，过几分钟即可验证通过，其他
需要验证的也同样操作。

除了Google的统计工具，还有就是国内使用很广的[CNZZ](http://zhanzhang.cnzz.com/)了，注册后，添加并验证你的网站就可以添加统计代码了，选好自己喜欢的样式，获得代码，可添加到`source/_includes/custom/footer.html`中。即可查看每天你的博客的流量，进行相应的优化了。

最后还要提的就是[百度站长工具](http://zhanzhang.baidu.com/site/index)和
[百度统计了](http://tongji.baidu.com/web/welcome/login)，方法和CNZZ方法类似
，统计代码也可以添加到`source/_includes/custom/footer.html`中。但是我发现
似乎百度统计并不太准确，并且百度很难搜的到我的博客。

我的统计代码添加如下，包括百度统计和CNZZ：
{% raw %}
``` html
<p>
  Copyright &copy; {{ site.time | date: "%Y" }} - {{ site.author }} -
  <span class="credit">
          Powered by 
          <a href="http://octopress.org">Octopress</a>
  </span>
  <script type="text/javascript">
        var _bdhmProtocol = (("https:" == document.location.protocol) ? " https://" : " http://");
        document.write(unescape("%3Cscript src='" + _bdhmProtocol + "hm.baidu.com/h.js%3F25fb42e16458b238f8da9ba05d6b9d4d' type='text/javascript'%3E%3C/script%3E"));
  </script>
  <script type="text/javascript">var cnzz_protocol = (("https:" == document.location.protocol) ? " https://" : " http://");document.write(unescape("%3Cspan id='cnzz_stat_icon_1000106316'%3E%3C/span%3E%3Cscript src='" + cnzz_protocol + "s22.cnzz.com/z_stat.php%3Fid%3D1000106316%26show%3Dpic' type='text/javascript'%3E%3C/script%3E"));</script>
</p>
```
{% endraw %}

## 摘要和语法高亮
如果想让文章在首页只显示一部分，只需要在文章中相应的位置添加`<!-- more -->`
即可，在`_config.yml`中修改`excerpt_link: "继续阅读 &rarr;"`来修改继续阅读
按钮的显示内容。

octopress自带了语法高亮功能，使用的是`pygements.rb`，使用方法见[Backtick Code Blocks](http://octopress.org/docs/plugins/backtick-codeblock/)，支持的语言见[Supported languages](http://pygments.org/docs/lexers/)。

其他方法见[embed code from a file](http://octopress.org/docs/plugins/include-code/)、[embed GitHub gists](http://octopress.org/docs/plugins/gist-tag/)或[Octopress代码高亮](http://xiongbupt.github.io/blog/2012/06/08/octopressdai-ma-gao-liang/)。

## 站内搜索
最后，还有一点我想实现但却始终没实现了的功能，就是站内搜索。octopress自带
了google的搜索，在搜索栏中搜索后，相当于在google中指定搜索域为你的博客进行
搜索，然后跳到Google页面，虽然能搜到你博客中的相关内容，但是作为有强迫症的我认为这和整个博客风格不太符。我想实现的效果是如[这个博客](http://yortz.it/about)所实现的站内搜索一样。
这就需要使用[Octopress Lunr.js plugin](https://github.com/yortz/octopress-lunr-js-search)，但我安装安装方法试验了好几次，还是没有成功。

如果谁安装成功了，还希望指点我一下。

---
好了，关于octopress也写了好几篇文章了，主要想记录一下自己搭建博客的过程，怕
自己忘掉，以后再搭还要从头再来。也是刚开始写博客，需要练习的过程，开始虽然
写的不好，但坚持下来总是会有收获的。

参考文章：

- [Octopress中的SEO](http://codemacro.com/2012/09/06/octopress-seo/)

- [Octopress技巧之设置关键字和描述](http://www.cnblogs.com/hswg/archive/2013/01/15/2860952.html)
