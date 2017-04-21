# For debugging purposes use: pp variable
#require("pp")

# Usage: {% auto_image %}
# or
# {% auto_image /path/to/images %}

module Jekyll

  class AutoImage < Liquid::Tag

    def initialize(tag_name, path, tokens)
      super
      @path = path
    end

    def render(context)
      site = context.registers[:site]
      base_dir = site.config['source']

      page = context.environments.first["page"]
      # page:

      # {
      #   "layout"=>"default",
      #   "title"=>"Startseite",
      #   "content"=> "<h1>Notes</h1>\n\n<ul>\n ...",
      #   "dir"=>"",
      #   "name"=>"index.html",
      #   "path"=>"index.html",
      #   "url"=>"/"
      # }
      if @path == nil || @path == ""
        dir = page["dir"]
      else
        dir = @path.strip
      end

      output = ''

      folder = File.join(base_dir, dir, "*.{jpg,png}")
      files = Dir.glob(folder)
      files.each do |image_fullpath|
        image_name = File.basename(image_fullpath)
        image_path = dir + '/' + image_name
        output += "<a href=\"#{image_path}\"><img src=\"#{image_path}\"></a>"
      end
      output
    end
  end

end

Liquid::Template.register_tag("auto_image", Jekyll::AutoImage)