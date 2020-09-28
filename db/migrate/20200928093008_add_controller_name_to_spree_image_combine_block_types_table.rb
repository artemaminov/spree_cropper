class AddControllerNameToSpreeImageCombineBlockTypesTable < ActiveRecord::Migration[5.2]
  def change
    add_column :spree_image_combine_block_types, :controller_name, :string
  end
end
