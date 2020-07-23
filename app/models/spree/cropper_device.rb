module Spree
  class CropperDevice < Spree::Base
    has_many :croppers, :class_name => 'Spree::Cropper'

    def self.dimensions
      Hash[all.map { |device| [device.name, {width: device.width, height: device.height}] }]
    end

    def self.imagemagick_hash
      Hash[all.map { |device| [device.name.to_sym, "#{device.width}x#{device.height}>"] }]
    end

    def self.largest
      self.dimensions.max_by { |device, dimensions| dimensions.max_by { |k, v| v } }[0]
    end

    def self.smallest
      self.dimensions.min_by { |device, dimensions| dimensions.max_by { |k, v| v } }[0]
    end
  end
end
