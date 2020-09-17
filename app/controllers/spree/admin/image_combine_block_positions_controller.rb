module Spree
  module Admin
    class ImageCombineBlockPositionsController < ResourceController
      before_action :load_data

      def new
        @records = []
      end

      def edit
        # Get all records of ImageCombine's BlockType selected model
        @records = Object.const_get(@image_combine_block_position.block_type.model_class_name).all
      end

      private

      def load_data
        @block_types = Spree::ImageCombineBlockType.all
      end

    end
  end
end
