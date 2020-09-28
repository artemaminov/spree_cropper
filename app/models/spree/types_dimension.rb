module Spree
  class TypesDimension < Spree::Base
    belongs_to :cropper_dimension, class_name: 'Spree::CropperDimension', foreign_key: 'spree_cropper_dimension_id', inverse_of: :types_dimensions
    belongs_to :block_type, class_name: 'Spree::ImageCombineBlockType', foreign_key: 'spree_image_combine_block_type_id', inverse_of: :types_dimensions
  end
end
