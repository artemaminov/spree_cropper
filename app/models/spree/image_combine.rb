module Spree
  class ImageCombine < Spree::Base
    has_one :cropped_image, as: :viewable, dependent: :destroy, class_name: 'Spree::CroppedImage'

    belongs_to :boundary_type, class_name: 'Spree::ImageCombineBlockType'

    accepts_nested_attributes_for :cropped_image

    scope :type, ->(model_class_name) { Spree::ImageCombineBlockType.find_by_model_class_name model_class_name }

    def attachment
      cropped_image.attachment
    end

    def attached?
      cropped_image.present? && attachment.present?
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

  end
end
