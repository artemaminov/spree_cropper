module Spree
  module Admin
    class CropperSettingsController < ResourceController
      def update
        config = Spree::CropperSetting.new
        preferences = params && params.key?(:preferences) ? params.delete(:preferences) : params
        preferences.each do |name, value|
          next unless config.has_preference? name
          config[name] = value
        end

        flash[:success] = Spree.t(:successfully_updated, resource: Spree.t(:cropper))
        redirect_to edit_admin_cropper_settings_path
      end
    end
  end
end
