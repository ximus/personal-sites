class AutoprefixWheel < Nanoc::Filter

  identifier :autoprefix
  type :text

  # Concatenate the Javascript, CoffeeScript or Sass content through [Sprockets2](http://getsprockets.org).
  # This method takes no options.
  #
  # @param [String] content The content to filter.
  #
  # @return [String] The filtered content.
  def run(content, params={})
    require "autoprefixer-rails"
    AutoprefixerRails.process(content, from: @item[:filename]).css
  end
end
