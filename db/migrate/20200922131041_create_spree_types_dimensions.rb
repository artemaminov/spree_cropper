class CreateSpreeTypesDimensions < ActiveRecord::Migration[5.2]
  def change
    create_table :spree_types_dimensions do |t|
      t.references :spree_cropper_dimension, foreign_key: true, index: { name: 'by_type_cropper'}
      t.references :spree_image_combine_block_type, foreign_key: true, index: { name: 'by_dimension_type'}
      t.integer :width
      t.integer :height

      t.timestamps
    end
  end
end