class CreateCropperDevicesTable < ActiveRecord::Migration[5.2]
  def change
    create_table :spree_cropper_devices do |t|
      t.string :name
      t.integer :width
      t.integer :height

      t.timestamps
    end
  end
end
