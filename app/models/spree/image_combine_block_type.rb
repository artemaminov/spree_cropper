module Spree
  class ImageCombineBlockType < Spree::Base
    has_many :block_positions, :class_name => 'Spree::ImageCombineBlockPosition', inverse_of: :block_type, dependent: :destroy

    def dimension_in_text
      "#{width}x#{height}"
    end
  end
end
