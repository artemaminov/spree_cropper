module Spree
  class ImageCombineBlockType < Spree::Base
    has_many :types_dimensions, class_name: 'Spree::TypesDimension', foreign_key: 'spree_image_combine_block_type_id', inverse_of: :block_type, dependent: :destroy
    has_many :cropper_dimensions, class_name: 'Spree::CropperDimension', through: :types_dimensions

    accepts_nested_attributes_for :types_dimensions

    def largest
      dimensions.max_by { |dimension, dimensions| dimensions.map { |k, v| v if [:height, :width].include? k }.compact }
    end

    def largest_in_text
      "#{largest[1][:width]}x#{largest[1][:height]}"
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

    # Fetch records for the specified model
    def fetch_data
      records = Object.const_get(model_class_name).all
      records.map { |k| { title: k.try(:name) || k.try(:title), id: k.try(:permalink) || k.try(:slug) || k.try(:id) } }
    end

  end
end
