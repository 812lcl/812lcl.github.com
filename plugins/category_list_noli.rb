module Jekyll
	class CategoryListTag < Liquid::Tag
		def render(context)
			html = ""
			categories = context.registers[:site].categories.keys
			categories.sort.each do |category|
				posts_in_category = context.registers[:site].categories[category].size
				category_dir = context.registers[:site].config['category_dir']
				category_url = File.join(category_dir, category.to_url)
				html << "<a href='/#{category_url}/'>#{category} (#{posts_in_category}) </a>\n"
			end
			html
		end
	end
end

Liquid::Template.register_tag('category_list_noli', Jekyll::CategoryListTag)
