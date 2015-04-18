# All files in the 'lib' directory will be loaded
# before nanoc starts compiling.
require "nutils"
require "erubis"
require "nokogiri"
require "yaml"
require 'nanoc/cachebuster'

Dir["../shared/lib/*"].each { |path| require path }

include Nanoc3::Helpers::Rendering
include Nanoc3::Helpers::Filtering
include Nanoc3::Helpers::LinkTo
include Nanoc::Helpers::CacheBusting

module Helpers
end

include Helpers