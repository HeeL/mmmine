class AddSharedToProducts < ActiveRecord::Migration
  def change
    add_column :products, :shared, :integer, default: 0
  end
end
