class AddCombinableColumnToImageCombineTable < ActiveRecord::Migration[5.2]
  def change
    add_reference :spree_image_combines, :combinable, polymorphic: true, index: true
  end
end
