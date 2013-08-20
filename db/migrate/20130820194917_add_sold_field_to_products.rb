class AddSoldFieldToProducts < ActiveRecord::Migration
  def change
    change_table :products do |t|
      t.boolean :sold, default: false
    end
  end
end
