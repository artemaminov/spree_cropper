module Spree
  class CropperDimension < Spree::Base
    has_many :croppers, class_name: 'Spree::Cropper', foreign_key: :dimension_id, inverse_of: :dimension, dependent: :destroy
    has_many :types_dimensions, class_name: 'Spree::TypesDimension', foreign_key: :spree_image_combine_block_type_id, inverse_of: :block_type, dependent: :destroy

    # Form data for data tag
    def self.dimensions
      Hash[all.order(width: :asc).map { |dimension| [dimension.id, { name: dimension.name.parameterize, name_i18n: dimension.name, width: dimension.width, height: dimension.height, preserveRatio: dimension.preserve_ratio }] }]
    end

    def self.largest
      dimensions.max_by { |_, dimensions| dimensions.map { |k, v| v if %i[height width].include? k }.compact }[0]
    end

    def self.smallest
      dimensions.min_by { |_, dimensions| dimensions.map { |k, v| v if %i[height width].include? k }.compact }[0]
    end

  end
end
