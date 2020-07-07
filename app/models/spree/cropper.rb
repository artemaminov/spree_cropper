module Spree
  class Cropper < Spree::Base
    # attr_accessor :dimensions
    belongs_to :cropped_image, required: true

    validates_associated :cropped_image

    def process(image, cropping_areas)
      cropping_areas.each do |area|
        image.attachment.variant(crop: area)
      end
    end

    def generate_cmd
      self.cmd = "#{ width }x#{ height }+#{ x }+#{ y }"
    end

  end
end
