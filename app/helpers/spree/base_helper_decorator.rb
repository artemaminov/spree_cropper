# frozen_string_literal: true
Spree::BaseHelper.module_eval do
  def resize_to_fill(image, options)
    image.variant(combine_options: { resize: "#{ options[:resize] }^", crop: "#{ options[:crop] }"}).processed
  end

  def fill_to_resize(image, options)
    image.variant(combine_options: { crop: "#{ options[:crop] }", resize: "#{ options[:resize] }^"}).processed
  end

    content_tag :picture do
      images = Spree::CropperDimension.dimensions.map { |dimension, dimensions|
        unless image.blank?
          content_tag :source, "", { media: "(max-width: #{ dimensions[:width] }px)", srcset: main_app.url_for(image.attachment.variant(crop: image.for(dimension)))}
        end
      }
      unless image.blank?
        images << [image_tag(main_app.url_for(image.attachment.variant(crop: image.for(Spree::CropperDimension.largest))), class: image_class)]
      end
      safe_join(images, "\n")
    end
  end
end
