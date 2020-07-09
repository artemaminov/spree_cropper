module Spree
  class Cropper < Spree::Base
    belongs_to :cropped_image, required: true

    validates_associated :cropped_image
    validates_presence_of :name, :width, :height, :x, :y

    after_save :process

    scope :for_device, ->(device) { where(name: device) }

    def process
      self.cropped_image.attachment.variant(crop: self.cmd)
    end

    def cmd
      "#{ width }x#{ height }+#{ x }+#{ y }"
    end

  end
end
