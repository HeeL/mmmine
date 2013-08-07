class AddFieldsToProduct < ActiveRecord::Migration
  def change
    change_table :products do |t|
      t.references :category
      t.references :sub_category
      t.string :title
      t.string :size
      t.integer :currency
    end

    add_index :products, :category_id
    add_index :products, :sub_category_id
  end
end
