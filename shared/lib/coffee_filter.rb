require 'coffee-script'

class CoffeeFilter < Nanoc::Filter
  identifier :coffee

  def run(content, params = {})
    CoffeeScript.compile(content)
  end
end
