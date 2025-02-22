module Helpers
  module Data
    def item_with_identifier(identifier)
      @items.find { |i| i.identifier == identifier }
    end

    def experience_item
      item_with_identifier("/resume/experience.yaml")
    end

    def experience_list
      experience_item[:main]
    end

    def various_sites_list
      experience_item[:various_sites]
    end
  end
end
