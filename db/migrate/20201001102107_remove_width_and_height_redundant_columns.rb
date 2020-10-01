class RemoveWidthAndHeightRedundantColumns < ActiveRecord::Migration[5.2]
  def change
    remove_column :spree_image_combine_block_types, :width, :integer
    remove_column :spree_image_combine_block_types, :height, :integer
  end
end
