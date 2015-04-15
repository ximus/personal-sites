# All files in the 'lib' directory will be loaded
# before nanoc starts compiling.
require "nutils"
require "erubis"
require "nokogiri"
require "yaml"

Dir["../../shared/lib/*"].each { |path| require path }

include Nanoc3::Helpers::Rendering
include Nanoc3::Helpers::Filtering
include Nanoc3::Helpers::LinkTo

module Helpers
  def item_with_identifier(identifier)
    @items.find { |i| i.identifier == identifier }
  end

  def experience_item
    item_with_identifier("/resume/experience/")
  end

  def experience_list
    experience_item[:main]
  end

  def various_sites_list
    experience_item[:various_sites]
  end
end

include Helpers