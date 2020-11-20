# frozen_string_literal: true

Spree::BaseHelper.module_eval do

  def fill_to_resize(image, *args)
    CropperService.fill_to_resize(image, args.shift)
  end

  def cropped_image_tag(image, options = {})
    return unless image.present? && image.attached?

    cs = CropperService.new(image)

    content_tag :picture do
      output = Spree::CropperDimension.dimensions.map do |device, dimensions|
        content_tag :source, '', {
          media: "(max-width: #{dimensions[:width]}px)",
          srcset: main_app.url_for(cs.fill_to_resize(
                                     crop: image.cropped_image.for(device),
                                     resize: "#{dimensions[:width]}x#{dimensions[:height]}"
                                   ))
        }
      end

      main_image = image_tag(main_app.url_for(cs.fill_to_resize(
                                                crop: image.cropped_image.for(Spree::CropperDimension.largest),
                                                resize: image.boundary_type.largest_in_text
                                              )), options)
      output << main_image
      cs.destroy_orphans
      safe_join(output, "\n")
    end
  end
end
