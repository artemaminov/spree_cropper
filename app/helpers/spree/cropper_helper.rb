module Spree
  module CropperHelper
    def cropped_image_tag(image)
      content_tag :picture do
        Spree::CropperDimension.dimensions.each do |device, dimensions|
          unless image.blank?
            content_tag :source, { media: { "max-width": "#{dimensions[:width]}px"}, srcset: main_app.url_for(image.attachment.variant(crop: image.for(device)))}
          end
        end
        unless image.blank?
          image_tag main_app.url_for(image.attachment.variant(crop: image.for('desktop')))
        end
      end
    end
  end
end
