module Spree
  class Cropper < Spree::Base
    belongs_to :cropped_image
    belongs_to :dimension, class_name: 'Spree::CropperDimension'

    accepts_nested_attributes_for :cropped_image
    accepts_nested_attributes_for :dimension

    validates_associated :cropped_image
    validates :width, :height, :x, :y, presence: true

    after_save :process

    scope :for_dimension, ->(id) { joins(:dimension).where('spree_cropper_dimensions.id': id) }

    def process
      cs = CropperService.new(cropped_image)
      options = { crop: cropped_image.for(dimension),
                  resize: "#{dimension[:width]}x#{dimension[:height]}"
      }
      cs.fill_to_resize(options)
    end

    def cmd
      "#{width}x#{height}+#{x}+#{y}"
    end

  end
end
