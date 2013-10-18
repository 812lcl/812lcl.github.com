# Octopress Lunr.js plugin

This plugin replaces [octopress](https://github.com/imathis/octopress) google search functionality with [lunr.js](http://lunrjs.com/).

Heavily inspired by [jekyll-lunr-search](https://github.com/slashdotdash/jekyll-lunr-js-search).

## How to use

Move files into place in your octopress install directory while maintaining directory folder structure

### 1. plugins/search-generator.rb

This octopress plugin creates a search.json file and populates it with entries results collected from your website posts & pages.

You can decide to untrack unneeded pages by adding those to the EXCLUDED array:

	EXCLUDE = ["Not found", "Internal Server Error", "Blog Archive", "store_bak", "Contact", "Search"]

### 2. Install octopress source files

The "source" folder contains the partials and libraries needed to run the plugin (feel free to edit those accordingly to your needs), each coffeescript file is compiled to js and compressed via [yui](http://yui.github.io/yuicompressor/) thanks to the [jekyll assets plugin](https://github.com/ixti/jekyll-assets). [Here](http://matt.coneybeare.me/how-to-setup-a-rails-like-asset-pipeline-with-octopress/) is a blog post with some useful instructions if you need some assitance on how to integrate it with your octopress install.

* source/_assets: contains needed js libs & main search class. 

* source/_includes/custom/lunr-search: contains needed partials and handlebars template used to display your search results.

* edit your _config.yml to enable lunr_search and disable simple_search

		#_config.yml
		lunr_search: true
		simple_search: #http://google.com/search
		
* edit template layout (this could vary depending on your own level of customization)

		#source/_includes/navigation.html
		
		<ul class="subscription" data-subscription="rss{% if site.subscribe_email %} email{% endif %}">
		<li><a href="{{ site.subscribe_rss }}" rel="subscribe-rss" title="subscribe via RSS">RSS</a></li>
		{% if site.subscribe_email %}
			<li><a href="{{ site.subscribe_email }}" rel="subscribe-email" title="subscribe via email">Email</a></li>
		{% endif %}
		</ul>

		{% if site.simple_search %}
		<form action="{{ site.simple_search }}" method="get">
		  <fieldset role="search">
		    <input type="hidden" name="q" value="site:{{ site.url | shorthand_url }}" />
		    <input class="search" type="text" name="q" results="0" placeholder="Search"/>
		  </fieldset>
		</form>
		{% endif %}

		{% if site.lunr_search == true %}
		  {% include custom/lunr_search/search-form.html %}
		{% endif %}

		{% include custom/navigation.html %}
		
* add /search page

Default search path for the form post action is "/search", be sure to create this page or change it together with the value passed to the constructor for the search object in case you want to use another value. Be sure to include entries.html

		#source/search/index.markdown
		---
		layout: page
		title: Search Results
		footer: false
		---

		{% include custom/lunr-search/entries.html %}

* add search-results handlebars partial via liquid into the head section of your page 

		# source/_includes/head.html
		{% include custom/lunr-search/search-results-template.html %}
		

### 3. Install dependencies.

Add dependencies to your app.js.coffee file (used to instantiate other libraries) via sprockets and instantiate a new LunrSearch search object when dom is ready.

	# source/_assets/javascripts/app.js.coffee
	
	# Following are plugin libraries.
	#= require ./libs/jquery.min
	#= require ./libs/lunr.min
	#= require ./libs/handlebars
	#= require ./libs/jXHR
	#= require ./libs/URI.min
	#= require lunr_search
	
	# Following are octopress related (defaults).
	#= require ./libs/swfobject-dynamic
	#= require modernizr-2.0
	#= require octopress
	
	# Instantiate a new search when dom is ready.
	$(document).ready ->
		new LunrSearch '#search-query',
	               		indexUrl: "/search.json",
	               	 	results: "#search-results",
	               	 	entries: ".entries",
	 	                template: "#search-results-template"
										
### PLEASE NOTE:

By default octopress is using ender.js as submodule library, so if you are using
it in your own octopress install some modifications are needed to prevent
conflicts. e.g.:

  
	#source/_assets/javascripts/app.js.coffee

	jQuery.noConflict() # prevents conflicts with Ender.js, use jQuery instead of $

	jQuery ->
		Handlebars.registerHelper "toLowerCase", (value) ->
		  (if (value and typeof value is "string") then new Handlebars.SafeString(value.toLowerCase()) else "")

## Assets:

### 1. search form (source/_includes/custom/lunr-search/search-form.html)

	<form action="/search" method="get">
	  <fieldset role ="search">
	    <input type="text" id="search-query" name="q" placeholder="Search" autocomplete="off" class="search" />
	  </fieldset>
	</form>


Search happens as you type, once at least three characters have been entered. 

Providing the form action and specifying the get method allows the user to hit return/enter to also submit the search.
Amend the form's action URL as necessary for the search page on your own site.

### 2. search result entries (source/_includes/custom/lunr-search/entries.html)

    <section id="search-results" style="display: none;">
      <p>Search results</p>
      <div class="entries">
      </div>
    </section>

This may be initially hidden as the plugin will show the element when searching.

### 3. search results Handlebars template (source/_includes/lunr-search/search-results-template.html).

	{% raw %}
	<script id="search-results-template" type="text/x-handlebars-template">
	  {{#entries}}
	    <article>
	      <h3>
	         <small><time datetime="{{date}}" pubdate>{{date}}</time></small>
	         <a href="{{url}}">{{title}}</a>
	         <p>tagged: {{ tags }} | category: <a href="/categories/{{category }}">{{category}}</a></p>
	      </h3>
	    </article>
	  {{/entries}}
	</script>
	{% endraw %}

Note the use of `{% raw %}` and `{% endraw %}` to ensure the HandleBars tags are not stripped out by Octopress.

## Test

Testing is possible thanks to [jasmine](http://pivotal.github.io/jasmine/), [jasmine-jquery](https://github.com/velesin/jasmine-jquery) and [jasmine-headless-webkit](https://github.com/johnbintz/jasmine-headless-webkit)

To setup the bogus app and run the tests

* Init and add octopress submodule

		$: git clone git://github.com/yortz/jekyll-lunr-js-search.git
		$: cd jekyll-lunr-search
		$: git submodule init
		$: git submodule update
		

PLEASE NOTE! Since the officially-maintained
[jekyll-assets](https://github.com/ixti/jekyll-assets) repo dropped liquid-preprocessing support (read more [here](https://github.com/ixti/jekyll-assets/issues/25))
you have to freeze to v0.3.5 or to another version [prior](https://github.com/ixti/jekyll-assets/commit/517c5fbabc36d8f95f335e05c33ee40c7801feb1) to dropped liquid-preprocessing support.
	
* Run app 

		$: cd spec/javascripts/fixtures/app
		$: rake preview

Above step bootstraps octopress and runs search_generator.rb plugin, updating your
public folder with a generated search.json file needed for the tests. You
can close your app once public/search.json is generated.

Go back to your jekyll-lunr-search dir and start
guard; it will automatically compile coffeescript files and watch for
changes in your source and spec directories.

* Guard

		$: cd jekyll-lunr-search
		$: rake wc
		
##Demo

You can find a working demo at [http://yortz.it/search](http://yortz.it/search)

## References

Credits go to [slashdot's jekyll-lunr-search](https://github.com/slashdotdash/jekyll-lunr-js-search).
