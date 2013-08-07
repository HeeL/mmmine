class CreateSubCategories < ActiveRecord::Migration
  def change
    create_table :sub_categories do |t|
      t.string :title
      t.references :category

      t.timestamps
    end
    add_index :sub_categories, :category_id
  end
end
