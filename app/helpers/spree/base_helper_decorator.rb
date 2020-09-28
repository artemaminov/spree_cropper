# frozen_string_literal: true
Spree::BaseHelper.module_eval do
  def resize_to_fill(image, options)
    image.variant(combine_options: { resize: "#{options[:resize]}^", crop: options[:crop] }).processed
  end

  def fill_to_resize(image, options)
    image.variant(combine_options: { crop: options[:crop], resize: "#{options[:resize]}^" }).processed
  end

  def cropped_image_tag(image, options = {})
    return unless image.present? && image.attached?

    content_tag :picture do
      output = Spree::CropperDimension.dimensions.map do |device, dimensions|
        content_tag :source, '', {
          media: "(max-width: #{dimensions[:width]}px)",
          srcset: main_app.url_for(fill_to_resize(
                                     image.attachment,
                                     crop: image.cropped_image.for(device),
                                     resize: "#{dimensions[:width]}x#{dimensions[:height]}"
                                   ))
        }
      end

      main_image = image_tag(main_app.url_for(fill_to_resize(image.attachment, {
                                                               crop: image.cropped_image.for(Spree::CropperDimension.largest),
                                                               resize: image.boundary_type.dimension_in_text
                                                             })), options)
      output << main_image
      safe_join(output, "\n")
    end
  end
end
