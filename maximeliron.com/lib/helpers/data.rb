module Helpers
  module Data
    def item_with_identifier(identifier)
      @items.find { |i| i.identifier == identifier }
    end

    def experience_item(suffix)
      item_with_identifier("/resume#{suffix ? "-#{suffix}" : ""}/experience.yaml")
    end

    def experience_list(suffix = nil)
      experience_item(suffix)[:main]
    end

    def various_sites_list(suffix = nil)
      experience_item(suffix)[:various_sites]
    end
  end
end
