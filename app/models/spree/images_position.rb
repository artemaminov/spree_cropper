class Spree::ImagesPosition < ApplicationRecord
  belongs_to :image_combine, inverse_of: :images_positions
  belongs_to :block_position, :class_name => 'Spree::ImageCombineBlockPosition', inverse_of: :images_positions

end
