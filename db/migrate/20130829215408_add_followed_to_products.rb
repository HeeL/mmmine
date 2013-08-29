class AddFollowedToProducts < ActiveRecord::Migration
  def change
    change_table :products do |t|
      t.integer :followed, default: 0
    end
  end
end
