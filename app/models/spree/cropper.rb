module Spree
  class Cropper < Spree::Base
    attr_accessor :dimensions
    belongs_to :cropped_image, required: true

    validates_associated :cropped_image
    validates_presence_of :name, :width, :height, :x, :y, :cmd

    before_validation :parse_dimensions

    def process(image, cropping_areas)
      cropping_areas.each do |area|
        image.attachment.variant(crop: area)
      end
    end

    def parse_dimensions
      dimensions_hash = JSON.parse(dimensions)
      cropper_params = dimensions_hash.slice('name', 'width', 'height', 'x', 'y')
      self.assign_attributes(cropper_params)
      self.cmd = "#{ width }x#{ height }+#{ x }+#{ y }"
    end

  end
end
