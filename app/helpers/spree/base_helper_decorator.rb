# frozen_string_literal: true

Spree::BaseHelper.module_eval do
  DEFAULT_CROP = { resize: '200x70^', crop: '200x70+0+0' }.freeze

  def fill_to_resize(image, options = {})
    crop = {
      crop: options.delete(:crop) || DEFAULT_CROP[:crop],
      resize: options.delete(:resize) || DEFAULT_CROP[:resize]
    }
    if options.delete(:reverse)
      image.variant(combine_options: { resize: "#{crop[:resize]}^", crop: crop[:crop] }).processed
    else
      image.variant(combine_options: { crop: crop[:crop], resize: "#{crop[:resize]}^" }).processed
    end
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

      main_image = image_tag(main_app.url_for(fill_to_resize(
                                                image.attachment, {
                                                  crop: image.cropped_image.for(Spree::CropperDimension.largest),
                                                  resize: image.boundary_type.largest_in_text
                                                }
                                              )), options)
      output << main_image
      safe_join(output, "\n")
    end
  end
end
