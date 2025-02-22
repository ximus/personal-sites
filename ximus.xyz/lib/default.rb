# All files in the 'lib' directory will be loaded
# before nanoc starts compiling.
require "erubis"
require "nokogiri"
require "yaml"
require 'nanoc/cachebuster'
require 'pry'
require 'active_support/all'

Dir["../shared/lib/*"].each { |path| require path }

include Nanoc::Helpers::Rendering
include Nanoc::Helpers::Filtering
include Nanoc::Helpers::LinkTo
include Nanoc::Helpers::Blogging
include Nanoc::Helpers::CacheBusting
include Nanoc::Helpers::XMLSitemap

module Helpers
end

include Helpers
