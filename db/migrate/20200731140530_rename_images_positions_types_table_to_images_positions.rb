class RenameImagesPositionsTypesTableToImagesPositions < ActiveRecord::Migration[5.2]
  def change
    rename_table :spree_images_positions_types, :spree_images_positions
  end
end
