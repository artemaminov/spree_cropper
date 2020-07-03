module Spree
  class CropperImage < Asset
    include Rails.application.config.use_paperclip ? Configuration::Paperclip : Configuration::ActiveStorage
    include Rails.application.routes.url_helpers

    # has_many :cropper_device, class_name: 'Spree::CropperDevice'
    # has_one :image, as: :viewable, class_name: 'Spree::Image'
    # belongs_to :asset, class_name: 'Spree::Asset'

    # accepts_nested_attributes_for :cropper_device
    # delegate :width, to: :cropper_device

    # validates_presence_of :width, :height, :x, :y, :cmd

    def styles
      self.class.styles.map do |_, size|
        width, height = size[/(\d+)x(\d+)/].split('x')

        {
            url: polymorphic_path(attachment.variant(resize: size), only_path: true),
            width: width,
            height: height
        }
      end
    end
  end
end
