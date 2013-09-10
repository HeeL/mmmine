class CreateNotifications < ActiveRecord::Migration
  def change
    create_table :notifications do |t|
      t.integer :from_user_id
      t.integer :to_user_id
      t.integer :action
      t.integer :object_id

      t.timestamps
    end

    add_index :notifications, :from_user_id
    add_index :notifications, :to_user_id
  end
end
