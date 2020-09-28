module Spree
  class ImageCombineBlockType < Spree::Base

    def dimension_in_text
      "#{width}x#{height}"
    end
  end
end
