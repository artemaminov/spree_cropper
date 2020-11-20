class CropperService
  DEFAULT_CROP = { resize: '200x70^', crop: '200x70+0+0' }.freeze

  def initialize(cropped_image)
    @attachment = if cropped_image.is_a? Spree::CroppedImage
                    cropped_image.attachment
                  elsif cropped_image.is_a? Spree::ImageCombine
                    cropped_image.cropped_image.attachment
                  else
                    false
                  end
    @variants_keys = []
  end

  # Crop and resize then by default
  # <tt>:crop</tt>    '200x70+0+0'  Crop dimensions and coordinates
  # <tt>:resize</tt>  '200x70^'     Resize dimensions
  # <tt>:reverse</tt> +boolean+     Resize then crop if +true+
  #
  #   CropperService.fill_to_resize(cropped_image) # => <tt>ActiveStorage::Variant</tt>
  def self.fill_to_resize(attachment, *args)
    options = args.shift
    cut(attachment, options).processed
  end

  def fill_to_resize(*args)
    variant = CropperService.fill_to_resize(@attachment, args.shift)
    variant_path = variant.service.path_for(variant.key)
    @variant_dir = File.dirname(variant_path)
    @variants_keys << File.basename(variant_path)
    variant
  end

  # Delete unused variants
  # +@variant_keys+ [Array] filled in #fill_to_resize
  def destroy_orphans
    Dir.each_child(@variant_dir) do |f|
      File.delete("#{@variant_dir}/#{f}") unless @variants_keys.include?(f)
    end
  end

  # Delete all variants
  def clean_variant_folder
    return if @attachment.blank?

    @variant_dir ||= Rails.root.join(@attachment.service.root, 'va', 'ri', 'variants', @attachment.key).to_s
    Dir.each_child(@variant_dir) do |f|
      File.delete("#{@variant_dir}/#{f}")
    end
  end

  def self.cut(attachment, options)
    crop = {
      crop: options[:crop] || CropperService::DEFAULT_CROP[:crop],
      resize: options[:resize] || CropperService::DEFAULT_CROP[:resize]
    }

    if options[:reverse]
      attachment.variant(combine_options: { resize: "#{crop[:resize]}^", crop: crop[:crop] })
    else
      attachment.variant(combine_options: { crop: crop[:crop], resize: "#{crop[:resize]}^" })
    end
  end

end
