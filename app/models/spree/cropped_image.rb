module Spree
  class CroppedImage < Asset
    FALLBACK_DIMENSION = '100x100+0+0'.freeze
    include Configuration::ActiveStorage
    include Rails.application.routes.url_helpers

    has_many :croppers, dependent: :destroy

    accepts_nested_attributes_for :croppers

    def for(dimension)
      return croppers.for_dimension(dimension).first.cmd if croppers.exists? && croppers.for_dimension(dimension).any?

      FALLBACK_DIMENSION
    end

    def styles
      self.class.styles.map do |_, size|
        width, height = size[/(\d+)x(\d+)/].split('x')
        { url: polymorphic_path(attachment.variant(resize: size), only_path: true),
          width: width,
          height: height }
      end
    end
  end
end
