module Spree
  class Cropper < Spree::Base
    belongs_to :cropped_image
    belongs_to :dimension, :class_name => 'Spree::CropperDimension'

    accepts_nested_attributes_for :cropped_image
    accepts_nested_attributes_for :dimension

    validates_associated :cropped_image
    validates_presence_of :width, :height, :x, :y

    after_save :process

    scope :for_dimension, ->(name) { joins(:dimension).where('spree_cropper_dimensions.name': name) }

    def process
      self.cropped_image.attachment.variant(crop: self.cmd)
    end

    def cmd
      "#{ width }x#{ height }+#{ x }+#{ y }"
    end

  end
end
