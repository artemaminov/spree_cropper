Spree::Admin::BaseHelper.module_eval do
  def cropper_image_tag(f, resource)
    resource.build_cropped_image if resource.cropped_image.blank?
    output = f.fields_for :cropped_image, resource.cropped_image do |cropped_image_fields|
      cropped_image_fields.label :attachment
      cropped_image_fields.file_field :attachment
      cropped_image_fields.check_box :_destroy
      unless resource.cropped_image.new_record?
        render partial: '/spree/admin/shared/cropper_form', locals: { resource: resource.cropped_image, cropped_image_fields: cropped_image_fields }
      end
    end
    output.html_safe
  end
end