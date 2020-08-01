class RenameNameColumnAtCropperTable < ActiveRecord::Migration[5.2]
  def change
    add_column :spree_croppers, :dimension_id, :integer
    croppers = Spree::Cropper.all
    croppers.each do |cropper|
      dimension = Spree::CropperDimension.find_by_name(cropper.name)
      cropper.update_column(:dimension_id, dimension.id)
    end
    remove_column :spree_croppers, :name
    add_index :spree_croppers, :dimension_id
  end
end
