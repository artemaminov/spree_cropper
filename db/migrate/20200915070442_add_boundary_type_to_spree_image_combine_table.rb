class AddBoundaryTypeToSpreeImageCombineTable < ActiveRecord::Migration[5.2]
  def change
    add_reference :spree_image_combines, :boundary_type
  end
end
