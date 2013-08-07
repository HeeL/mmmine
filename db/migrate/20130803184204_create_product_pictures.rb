class CreateProductPictures < ActiveRecord::Migration
  def change
    create_table :product_pictures do |t|
      t.references :product
      t.attachment :picture
      
      t.timestamps
    end
  end
end
