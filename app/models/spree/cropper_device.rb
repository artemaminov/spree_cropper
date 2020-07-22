module Spree
  class CropperDevice < Spree::Base
    has_many :croppers, :class_name => 'Spree::Cropper'

    def self.dimensions
      Hash[all.map { |device| [device.name, {width: device.width, height: device.height}] }]
    end
  end
end
