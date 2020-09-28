module Spree
  class ImageCombineBlockType < Spree::Base
    has_many :types_dimensions, class_name: 'Spree::TypesDimension', foreign_key: 'spree_image_combine_block_type_id', inverse_of: :block_type, dependent: :destroy
    has_many :cropper_dimensions, class_name: 'Spree::CropperDimension', through: :types_dimensions

    accepts_nested_attributes_for :types_dimensions

    def dimension_in_text
      "#{width}x#{height}"
    end

    def dimensions
      Hash[types_dimensions.order(width: :asc).map do |type|
        [
          type.cropper_dimension.id,
          { name: type.cropper_dimension.name.parameterize,
            name_i18n: type.cropper_dimension.name,
            width: type.width,
            height: type.height,
            preserveRatio: type.cropper_dimension.preserve_ratio }
        ]
      end
      ]
    end

    def self.model_id(model_class_name)
      find_by(model_class_name: model_class_name).try(:id)
    end

  end
end
