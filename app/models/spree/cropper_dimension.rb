module Spree
  class CropperDimension < Spree::Base
    has_many :croppers, :class_name => 'Spree::Cropper'

    # Form data for data tag
    def self.dimensions
      Hash[all.map { |dimension| [dimension.id, {name: dimension.name, width: dimension.width, height: dimension.height, preserveRatio: dimension.preserve_ratio}] }]
    end

    def self.imagemagick_hash
      Hash[all.map { |dimension| [dimension.name.to_sym, "#{dimension.width}x#{dimension.height}^"] }]
    end

    def self.largest
      self.dimensions.max_by { |dimension, dimensions| dimensions.max_by { |k, v| v if ['height', 'width'].include? k } }[0]
    end

    def self.smallest
      self.dimensions.min_by { |dimension, dimensions| dimensions.max_by { |k, v| v if ['height', 'width'].include? k } }[0]
    end
  end
end
