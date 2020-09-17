class AddMultipleColumnToImageCombineBlockTypeTable < ActiveRecord::Migration[5.2]
  def change
    add_column :spree_image_combine_block_types, :multiple, :boolean, default: false
  end
end
