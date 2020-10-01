module Spree
  class ImagesPosition < Spree::Base
    belongs_to :image_combine, inverse_of: :images_positions
    belongs_to :block_position, :class_name => 'Spree::ImageCombineBlockPosition', inverse_of: :images_positions

  end
end
