class CreateSpreeCroppersTable < ActiveRecord::Migration[5.2]
  def change
    create_table :spree_croppers do |t|
      t.integer :width
      t.integer :height
      t.integer :x
      t.integer :y
      t.string :cmd

      t.timestamps
    end
  end
end
