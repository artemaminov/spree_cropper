module Spree
  module Admin
    class ImageCombineBlockTypesController < ResourceController
      def index
        if params[:type].present?
          type = Spree::ImageCombineBlockType.find(params[:type])
          if type
            records = Object.const_get(type.model_class_name).all
            if request.xhr?
              respond_to do |format|
                format.json {
                  render json: {records: records}
                }
              end
            end
          end
        end
      end
    end
  end
end
