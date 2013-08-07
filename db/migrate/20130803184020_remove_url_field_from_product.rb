class RemoveUrlFieldFromProduct < ActiveRecord::Migration
  def up
    remove_column :products, :url
  end
end
