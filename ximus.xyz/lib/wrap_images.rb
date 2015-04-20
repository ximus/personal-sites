require 'nokogiri'

module Nanoc
  module Filters
    class WrapImages < Nanoc::Filter
      identifier :wrap_images
      type :text

      def run(content, options = {})
        if @item[:kind] != 'article'
          return content
        end
        document = Nokogiri::HTML(content)
        images = document.css('article img').wrap(%[
          <a data-lightbox="site-image-blah" target="_blank"></a>
        ])

        images.each do |image|
          image.parent[:href] = image[:src]
        end
        document.to_html
      end
    end
  end
end

