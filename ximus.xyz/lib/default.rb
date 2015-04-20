# All files in the 'lib' directory will be loaded
# before nanoc starts compiling.
require "nutils"
require "erubis"
require "nokogiri"
require "yaml"
require 'nanoc/cachebuster'
require 'pry'
require 'active_support/all'

Dir["../shared/lib/*"].each { |path| require path }

include Nanoc3::Helpers::Rendering
include Nanoc3::Helpers::Filtering
include Nanoc3::Helpers::LinkTo
include Nanoc3::Helpers::Blogging
include Nanoc::Helpers::CacheBusting
include Nanoc3::Helpers::XMLSitemap

module Helpers
end

include Helpers