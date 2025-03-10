require 'nokolexbor'
require 'open-uri'
require 'fileutils'
require 'random/formatter'
require 'digest/md5'

# look for img src references to external images (not local), then save them locally
# to be served locally
class ImageSnapFilter < Nanoc::Filter
  identifier :image_snap

  def run(content, params = {})
    doc = Nokolexbor::HTML(content)
    FileUtils.mkdir_p("#{config[:output_dir]}/image_snaps")
    rand = Random.new
    selectors = (params[:selectors] || ['img[src]']).join(", ")
    doc.css(selectors).each do |node|
      src = node.attributes["src"].to_s
      hash = Digest::MD5.hexdigest(src)[0..6]
      next unless src.start_with?("http") || src.start_with?("//")
      extension =  File.extname(URI.parse(src).path)
      filename = "#{hash}#{extension}"
      path = "/image_snaps/#{filename}"
      output_path = File.join(config[:output_dir], path)
      log.debug "image snap: replacing #{src.inspect} with #{path.inspect}"
      unless File.exist?(output_path)
        log.debug "image snap: #{output_path.inspect} does not exist, downloading ..."
        File.write(output_path, URI.open(src).read)
      end
      node.attributes["src"].value = path
    end
    doc.to_html
  end

  def log
    @log ||= Logger.new(STDOUT)
  end
end
