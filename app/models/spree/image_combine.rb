module Spree
  class ImageCombine < Spree::Base
    has_one :cropped_image, as: :viewable, dependent: :destroy, class_name: 'Spree::CroppedImage'
    has_many :images_positions, dependent: :destroy, class_name: 'Spree::ImagesPosition', inverse_of: :image_combine
    has_many :block_positions, dependent: :destroy, :class_name => 'Spree::ImageCombineBlockPosition', through: :images_positions, inverse_of: :image_combines

    belongs_to :boundary_type, class_name: 'Spree::ImageCombineBlockType'

    accepts_nested_attributes_for :cropped_image
    accepts_nested_attributes_for :images_positions
    accepts_nested_attributes_for :block_positions

    scope :position, ->(controller_name, id) { where('spree_image_combine_block_positions.controller_name' => controller_name, 'spree_image_combine_block_positions.anchor_uid' => id) }
    scope :type, ->(model_class_name) { Spree::ImageCombineBlockType.find_by_model_class_name model_class_name }

    def attachment
      cropped_image.attachment
    end

    def attached?
      cropped_image.present? && attachment.present?
    end

    def self.fetch(object, controller_name)
      type = type(object).first
      return if type.nil?
      position = joins(:block_positions).where("spree_image_combine_block_positions.controller_name": controller_name, "spree_image_combine_block_positions.block_id": object.id, "spree_image_combine_block_positions.block_type_id": type.id).first
      return position.cropped_image unless position.blank?
      false
    end

    def dimensions
      type
    end

    # Get type boundaries dimensions
    def boundaries
      if boundary_type.present?
        { width: boundary_type.width, height: boundary_type.height }
      else
        false
      end
    end

    # Get type class name
    def type
      Spree::ImageCombine.type combinable_type
    end


    # Legacy
    def self.type_dimensions(object)
      type = get_type(object)
      "#{type.width}x#{type.height}"
    end

    def self.get_type(object)
      Spree::ImageCombineBlockType.find_by_model_class_name(object.class.name)
    end
  end
end
