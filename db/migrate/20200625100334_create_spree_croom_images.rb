class CreateSpreeCroomImages < ActiveRecord::Migration[5.2]
  def change
    create_table :spree_croom_images do |t|
      t.references Spree::CroomDevice, foreign_key: true
      t.references Spree::Asset, foreign_key: true

      t.timestamps
    end
  end
end
