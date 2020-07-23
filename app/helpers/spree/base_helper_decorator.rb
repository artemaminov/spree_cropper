Spree::BaseHelper.module_eval do
  def cropped_image_tag(image, image_class = "")
    content_tag :picture do
      images = Spree::CropperDevice.dimensions.map { |device, dimensions|
        unless image.blank?
          content_tag :source, "", { media: "(max-width: #{ dimensions[:width] }px)", srcset: main_app.url_for(image.attachment.variant(crop: image.for(device)))}
        end
      }
      unless image.blank?
        images << [image_tag(main_app.url_for(image.attachment.variant(crop: image.for(Spree::CropperDevice.largest))), class: image_class)]
      end
      safe_join(images, "\n")
    end
  end
end
