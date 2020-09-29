module Spree
  module Admin
    class ImageCombinesController < ResourceController
      def edit
        respond_to do |format|
          # format.html
          format.json do
            boundaries = Spree::ImageCombineBlockType.find params[:type_id]
            render json: boundaries.dimensions
          end
        end
      end
    end
  end
end
