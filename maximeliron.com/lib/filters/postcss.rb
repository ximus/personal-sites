class PostcssFilter < Nanoc::Filter
  identifier :postcss

  def run(content, params = {})
    out, err, _ = Open3.capture3("npx postcss", stdin_data: content)
    raise err unless err.empty?
    out
  end
end
