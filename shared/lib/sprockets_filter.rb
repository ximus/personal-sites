class SprocketWheel < Nanoc::Filter

  identifier :sprockets
  type :text

  # Concatenate the Javascript, CoffeeScript or Sass content through [Sprockets2](http://getsprockets.org).
  # This method takes no options.
  #
  # @param [String] content The content to filter.
  #
  # @return [String] The filtered content.
  def run(content, params={})
    require "sprockets"

    # load_path can be a String or Array of Strings
    load_path = params[:load_path] || File.dirname(@item[:filename])
    # The item's filename
    filename  = File.basename(@item[:filename])

    env = Sprockets::Environment.new

    # Assign Array or String load paths to Sprockets
    if load_path.kind_of?(Array)
      load_path.each do |path|
        env.append_path(path)
      end
    else
      env.append_path(load_path)
    end

    # Get the Sprockets BundledAsset object for the item
    asset = env.find_asset(filename)

    # this just doesn't work anymore in modern sprockets
    # Make sure sure the item is recompiled if a depended asset is dirty!
    # Gather dependent items
    # item_dependencies = asset.dependencies.collect do |asset_dep|
    #   # Find its corresponding Nanoc item.
    #   imported_filename_to_item(asset_dep.pathname)
    # end

    # Register them as dependendcies with Nanoc
    # depend_on(item_dependencies)

    # Output compiled asset
    asset.to_s
  end

  private

  # Find a Nanoc item using a filename
  def imported_filename_to_item(filename)
    path = Pathname.new(filename).realpath
    @items.find do |i|
      next if i[:content_filename].nil?
      Pathname.new(i[:content_filename]).realpath == path
    end
  end
end
