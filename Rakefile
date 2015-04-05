task :deploy => [
  'compile:pdf_resume',
  'optimize:jpeg',
  'optimize:png',
  'optimize:css',
  'optimize:js']

namespace :optimize do
  desc 'Optimise JPEG images in output/images directory using jpegoptim'
  task :jpeg do
    puts `find output/images -name '*.jpg' -exec jpegoptim {} \\;`
  end

  desc 'Optimise PNG images in output/images directory using optipng'
  task :png do
    puts `find output/images -name '*.png' -exec optipng {} \\;`
  end

  desc 'Compress CSS files in output/style directory using YUI Compressor'
  task :css do
    puts `find output/stylesheets -name '*.css' -exec yuicompressor --type css '{}' -o '{}' \\;`
  end

  desc 'Compress JavaScript files in output/script directory using YUI Compressor'
  task :js do
    puts `find output/javascripts -name '*.js' -exec yuicompressor --type js '{}' -o '{}' \\;`
  end

  desc 'Compress HTML files in output directory using Google HTML Compressor'
  task :html do
    puts `find output -name '*.html' -exec htmlcompressor --type html '{}' -o '{}' \\;`
  end

  desc 'Compress XML files in output directory using Google HTML Compressor'
  task :xml do
    puts `find output -name '*.xml' -exec htmlcompressor --type xml '{}' -o '{}' \\;`
  end

  desc 'Optimise all image, CSS, JavaScript, HTML and XML files in the output directory'
  task :all => [:jpeg, :png, :css, :js, :html, :xml]
end

namespace :compile do
  desc "Generates the pdf version of my resume"
  task :pdf_resume do
    # puts `bundle exec wkpdf -t 10000 --stylesheet-media print  -n --caching false -m 52  --source output/resume/index.html --output output/resume/maxime-liron-resume.pdf`
    puts `wkhtmltopdf --print-media-type output/resume/index.html output/resume/maxime-liron-resume.pdf`
  end
end

namespace :beautify do
  desc "Make the HTML pretty"
  task :html do
    require "htmlbeautifier/beautifier"
    # This isn't working yet, ouput is weird
    `find output -name '*.html'`.split("\n").each do |filepath|
      file = File.open(filepath, 'r+')
      output = ""
      HtmlBeautifier::Beautifier.new(output).scan(file.read)
      file.truncate(0)
      file.write(output)
      file.close
    end
  end
end