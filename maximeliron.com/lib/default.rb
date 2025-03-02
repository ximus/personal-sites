# All files in the 'lib' directory will be loaded
# before nanoc starts compiling.
require "pry"
require "erubis"
require "nokogiri"
require "yaml"
require 'nanoc/cachebuster'

Dir["../shared/lib/*"].each { |path| require path }

include Nanoc::Helpers::Rendering
include Nanoc::Helpers::Filtering
include Nanoc::Helpers::LinkTo
include Nanoc::Helpers::CacheBusting
