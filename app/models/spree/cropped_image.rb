module Spree
  class CroppedImage < Asset
    include Configuration::ActiveStorage
    include Rails.application.routes.url_helpers

    has_many :croppers, dependent: :destroy

    accepts_nested_attributes_for :croppers

    def for(device)
      if croppers.exists?
        return croppers.for_device(device).first.cmd unless croppers.for_device(device).first.blank?
      end
      '100x100+0+0'
    end

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
