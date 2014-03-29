---
layout: post
title: "Octopress主题样式修改"
date: 2013-10-27 11:52
comments: true
categories: Octopress
tags: [octopress, 博客, ruby, html]
keywords: octopress, blog, github, linux
description: Octopress主题样式修改
---
[上一篇文章](http://812lcl.github.io/blog/2013/10/26/octopressce-bian-lan-ji-ping-lun-xi-tong-ding-zhi/)写了很多侧边栏和社会化评论分享系统的定制，现在说一说，主题样式的修改。

## 1. Header，Navigation，footer

这几个部分是经常需要个性化定制的，在`source/_includes`中存在其对应的HTML文件，这是主题默认的文件，更换主题，更新octopress会被覆盖，所以应该编辑`source/_includes/custom`下的文件来实现修改。

### 1.1 Header（标题栏）
标题栏显示的内容为`/source/_includes/custom/header.html`所实现的，其中title和subtitle在`_config.yml`中定义，你可以进行适量的修改：
{% raw %}
``` html
<hgroup>
  <h1><a href="{{ root_url }}/">{{ site.title }}</a></h1>
  {% if site.subtitle %}
    <h2>{{ site.subtitle }}</h2>
  {% endif %}
</hgroup>
```
{% endraw %}
<!--more-->
### 1.2 Navigation（导航栏）
可以自行为导航栏添加项目，链接至不同的页面，在`/source/_includes/custom/navigation.html`中编辑即可。
{% raw %}
```
<ul class="main-navigation">
  <li><a href="{{ root_url }}/">博客主页</a></li>
  <li><a href="{{ root_url }}/blog/archives">文章列表</a></li>
  <li><a href="{{ root_url }}/category-cloud">分类云</a></li>
  <li><a href="{{ root_url }}/about">关于</a></li>
</ul>
```
{% endraw %}

当想添加一些页面，如“关于”页面，可以试验`rake new_page['name']`命令来创建，如`rake new_page['about']`后，会建立`source/about/index.html`文件，在此文件编辑，添加自己想要展示的内容，然后再`navigation.html`里添加正确的路径即可，如`<li><a href="{{ root_url }}/about">关于</a></li>`。

### 1.3 footer（尾栏）
在`source/_includes/custom/footer.html`中编辑尾栏：
{% raw %}
```
<p>
  Copyright &copy; {{ site.time | date: "%Y" }} - {{ site.author }} -
  <span class="credit">
          Powered by 
          <a href="http://octopress.org">Octopress</a>
  </span>
</p>
```
{% endraw %}
默认显示`Copyright@2013 - author - Powered by Octopress`，你可以添加自己想显示在尾栏的东西，第三方统计流量统计工具也可以添加到这，如CNZZ、Google analytics和百度统计等，使用这些工具可以更详细的分析网站流量，改善引流措施，完善网站，具体添加方法见[统计工具与SEO](http://812lcl.com/blog/2013/10/29/octopresstian-jia-tong-ji-yu-seo)。

## 2. 样式修改

添加或修改控制样式，需编辑`sass/custom/_styles.scss`，博客的所有颜色控制在`/sass/base/_theme.scss`中进行设置。定制自己的配色，编辑`sass/custom/_colors.scss`。查看[HSL COLOR PICKER](http://hslpicker.com/#e1ff00)，帮你挑选喜欢的颜色。

修改布局，需要编辑`sass/base/_layout.scss`，可以修改各部分的宽度等。
### 2.1 添加背景图片
在`sass/custom/_styles.scss`中添加：
``` scss
html {
        background: #555555 url("/images/bg3.jpg");
        //background: #555555;
}

body > div { 
        background-image: none; 
        //background: #F5F5D5
} //侧边栏

body > div > div { //文章内容
        background-image: none; 
        //background: #F5F5D5; 
        //background: url("/images/bg.jpg");
}
```
将背景图片放入`source/images/`中，修改上述代码中的路径指向想要的图片，即可
更改博客、侧边栏或文章的背景图片。博客使用背景图片后，与Header区不太和谐，
所以我在`/sass/base/_theme.scss`中将`header-bg`设置成透明色了。

### 2.2 LOGO图片
我所说的logo图片有两种，一个是打开一个网页时，标签栏上显示的小图片。还有一个是标题栏主标题旁的图片。

首先针对于第一种可以选择你喜欢的图片（大小适中），替换`source`目录下的`favicon.png`即可。

或者将logo图片放入`source/images`中，然后修改`source/_includes/head.html`，找到`favicon.png`，修改其路径指向你的图片即可。

对于主标题旁的图片需要在`sass/custom/_styles.scss`中填入如下语句：
``` scss
//Blog logo pic
@media only screen and (min-width: 550px) {

        body > header h1{
                background: url("/images/logo1.png") no-repeat 0 1px;
                padding-left: 65px;
        }

        body > header h2 { padding-left: 65px; }
}
```
根据自己情况进行修改即可。

### 2.3 导航栏倒圆角
我设置的header区背景色透明，所以导航栏的直角有些尖锐，在`sass/custom/_styles.scss`中添加如下语句，将其修改为圆角：
``` scss
//倒圆角
@media only screen and (min-width: 1040px) {
        body > nav {
                @include border-top-radius(.4em);
        }

        body > footer {
                @include border-bottom-radius(.4em);
        }
}
```

## 3. 滑动返回顶部按钮
当文章较长，通常希望有一个返回顶部的按钮，如下方法实现了在页面右下方添加一个返回顶部的图片按钮，点击后可以滑动的返回顶部。

首先创建`source/javascripts/top.js`，实现滑动返回顶部效果，添加如下代码：
``` js
function goTop(acceleration, time)
{
        acceleration = acceleration || 0.1;
        time = time || 16;

        var x1 = 0;
        var y1 = 0;
        var x2 = 0;
        var y2 = 0;
        var x3 = 0;
        var y3 = 0;

        if (document.documentElement)
        {
                x1 = document.documentElement.scrollLeft || 0;
                y1 = document.documentElement.scrollTop || 0;
        }
        if (document.body)
        {
                x2 = document.body.scrollLeft || 0;
                y2 = document.body.scrollTop || 0;
        }
        var x3 = window.scrollX || 0;
        var y3 = window.scrollY || 0;

        var x = Math.max(x1, Math.max(x2, x3));
        var y = Math.max(y1, Math.max(y2, y3));

        var speed = 1 + acceleration;
        window.scrollTo(Math.floor(x / speed), Math.floor(y / speed));

        if(x > 0 || y > 0)
        {
                var invokeFunction = "goTop(" + acceleration + ", " + time + ")";
                window.setTimeout(invokeFunction, time);
        }         
}
```
然后创建`source/_includes/custom/totop.html`，设置返回顶部按钮样式和位置，代码如下：
``` html
<!--返回顶部开始-->
<div id="full" style="width:0px; height:0px; position:fixed; right:180px; bottom:150px; z-index:100; text-align:center; background-color:transparent; cursor:pointer;">
        <a href="#" onclick="goTop();return false;"><img src="/images/top.png" border=0 alt="返回顶部"></a>
</div>
<script src="/javascripts/top.js" type="text/javascript"></script>
<!--返回顶部结束-->
```
最后，还需要将返回顶部的图片放入`source/images`，命名为`top.png`（或修改totop.html中图片的路径）。

## 4. 二维码展示
在关于页面或边栏可以展示你的个人博客的二维码，方便移动终端扫描访问你的博客，插件主页[点击这里](https://github.com/sailor79/Octopress-dynamic-QR-Code-aside)。

在侧边栏显示，则将`qrcode.html`放入`source/_includes/custom/asides/`中，在`_config.yml`中`default_asides`添加`custom/asides/qrcode.html`即可显示。

或者将`qrcode.html`代码添加到你想展示的页面的HTML文件中亦可。

---

参考文章：

- [为Octopress修改主题和自定义样式](http://yanping.me/cn/blog/2012/01/07/theming-and-customization/)

- [Octopress主题改造](http://shanewfx.github.io/blog/2012/08/13/improve-blog-theme/)

- [用 JavaScript 实现变速回到顶部](http://www.neoease.com/javascript-go-top/)
