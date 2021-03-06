class CreateSpreeCroppersTable < ActiveRecord::Migration[5.2]
  def change
    create_table :spree_croppers do |t|
      t.references :cropped_image
      t.references :dimension
      t.string :name
      t.integer :width
      t.integer :height
      t.integer :x
      t.integer :y

      t.timestamps
    end
  end
end
