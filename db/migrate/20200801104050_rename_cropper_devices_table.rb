class RenameCropperDevicesTable < ActiveRecord::Migration[5.2]
  def change
    rename_table :spree_cropper_devices, :spree_cropper_dimensions
  end
end
