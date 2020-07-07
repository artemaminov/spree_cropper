module Spree
  class CroppedImage < Asset
    include Rails.application.config.use_paperclip ? Configuration::Paperclip : Configuration::ActiveStorage
    include Rails.application.routes.url_helpers

    has_many :croppers

    accepts_nested_attributes_for :croppers

    attr_accessor :dimensions
    # validates_presence_of :dimensions
    # before_save :f1
    # before_update :f2
    # before_validation :f3
    def f1
      byebug
      # puts dimensions
    end
    def f2
      byebug
      # puts dimensions
    end
    def f3
      byebug
      # puts dimensions
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
