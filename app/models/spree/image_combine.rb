module Spree
  class ImageCombine < Spree::Base
    has_one :cropped_image, as: :viewable, class_name: 'Spree::CroppedImage', dependent: :destroy

    belongs_to :boundary_type, class_name: 'Spree::ImageCombineBlockType', optional: true

    accepts_nested_attributes_for :cropped_image

    before_update :clean_folder

    delegate :attachment, :is_valid?, to: :cropped_image

    # Is image attached?
    def attached?
      cropped_image.present? && attachment.present?
    end

    # Get type dimensions hash
    # <tt>Spree::ImageCombineBlockType#dimensions</tt>
    # {:dimension.id=>{
    #   :name=>"telefon",
    #   :name_i18n=>"Телефон",
    #   :width=>375,
    #   :height=>800,
    #   :preserveRatio=>true
    # }}
    def boundaries
      if boundary_type.present?
        boundary_type.dimensions
      else
        false
      end
    end

    private

    # Clean folder before new variant created
    def clean_folder
      cs = CropperService.new(cropped_image)
      cs.clean_variant_folder
    end

  end
end
