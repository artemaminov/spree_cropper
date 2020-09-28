module Spree
  module Admin
    class ImageCombineBlockTypesController < ResourceController
      def index
        return if params[:type].blank?

        respond_to do |format|
          format.json do
            type = Spree::ImageCombineBlockType.find(params[:type])
            return if type.blank?

            records = Object.const_get(type.model_class_name).all
            render json: { records: records }
          end
        end
      end

      def new
        @image_combine_block_type.cropper_dimensions = Spree::CropperDimension.all
      end

      def edit
        if @image_combine_block_type.cropper_dimensions.count < Spree::CropperDimension.all.count
          image_combine_croppers = @image_combine_block_type.cropper_dimensions
          spree_croppers = Spree::CropperDimension.all
          @image_combine_block_type.cropper_dimensions << spree_croppers - image_combine_croppers
        end
      end
    end
  end
end
