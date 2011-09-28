# All files in the 'lib' directory will be loaded
# before nanoc starts compiling.
require "nutils"
require "yaml"

include Nanoc3::Helpers::Rendering
include Nanoc3::Helpers::LinkTo

module Helpers
  def item_with_identifier(identifier)
    @items.find { |i| i.identifier == identifier }
  end
  
  def experience_list 
    item_with_identifier("/resume/experience/")[:main]
  end
  
  def various_sites_list 
    item_with_identifier("/resume/experience/")[:various_sites]
  end
end

include Helpers