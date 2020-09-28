module Spree
  class ImageCombine < Spree::Base
    has_one :cropped_image, as: :viewable, class_name: 'Spree::CroppedImage', dependent: :destroy

    belongs_to :boundary_type, class_name: 'Spree::ImageCombineBlockType', optional: true

    accepts_nested_attributes_for :cropped_image

    scope :type, ->(model_class_name) { Spree::ImageCombineBlockType.find_by(model_class_name: model_class_name) }

    delegate :attachment, :is_valid?, to: :cropped_image

    def attached?
      cropped_image.present? && attachment.present?
    end

    # Get type boundaries dimensions
    def boundaries
      if boundary_type.present?
        boundary_type.dimensions
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
