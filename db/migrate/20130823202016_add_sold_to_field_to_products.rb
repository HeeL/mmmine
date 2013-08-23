class AddSoldToFieldToProducts < ActiveRecord::Migration
  def up
    remove_column :products, :sold
    change_table :products do |t|
      t.integer :sold_to, default: 0
    end
  end
end
