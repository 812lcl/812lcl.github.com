---
layout: page
title: "category_cloud"
date: 2013-10-14 22:43
comments: false
sharing: false
footer: true
---

<div id='Category-cloud'>
	<section>
	  	<h1>分类云</h1>
		<ul class="category-cloud">
			{% category_cloud_big bgcolor:#f2f2f2 %}
		</ul>
	</section>
	<section>
		 <h1>分类目录</h1>
		 <ul id="categories">
			 {% category_list_noli %}
		 </ul>
	</section>
	<section>
		<h1>标签云</h1>
		<ul id="Tag-cloud">
			{% tag_cloud_big bgcolor:#f2f2f2 %}
		</ul>
	</section>
	<section>
	  	<h1>标签列表</h1>
		<ul class="tag-cloud">
			{% tag_list font-size: 90-210%, limit: 10, style: para %}
		</ul>
	</section>
</div>
<div>
<script type="text/javascript" src="http://jd.revolvermaps.com/2/1.js?i=3epahcya604&amp;s=350&amp;m=0&amp;v=true&amp;r=false&amp;b=000000&amp;n=false&amp;c=ff0000" async="async"></script>
</div>
