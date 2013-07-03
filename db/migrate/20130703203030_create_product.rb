class CreateProduct < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.references :user
      t.string :url
      t.attachment :picture

      t.timestamps
    end
    add_index :products, :user_id
  end
end
