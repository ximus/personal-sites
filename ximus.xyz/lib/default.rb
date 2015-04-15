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
end

include Helpers