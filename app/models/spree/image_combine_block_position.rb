module Spree
  class ImageCombineBlockPosition < Spree::Base
    belongs_to :block_type, class_name: 'Spree::ImageCombineBlockType', inverse_of: :block_positions
    has_many :images_positions, class_name: 'Spree::ImagesPosition', inverse_of: :block_position, dependent: :destroy
    has_many :image_combines, :class_name => 'Spree::ImageCombine', through: :images_positions, inverse_of: :block_positions

    validates_presence_of :name, :block_id

    accepts_nested_attributes_for :image_combines, :images_positions, :block_type

    def self.with_no_image_assigned
      joins("LEFT OUTER JOIN spree_images_positions ON spree_image_combine_block_positions.id = spree_images_positions.block_position_id").where("spree_images_positions.block_position_id": nil)
    end

    def fetch_block_name
      Object.const_get(block_type.model_class_name).find(block_id).name rescue nil
    end

  end
end
