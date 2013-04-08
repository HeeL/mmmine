class CreateUserSettings < ActiveRecord::Migration
  def change
    create_table :user_settings do |t|
      t.references :user
      t.boolean :new_follower_notify
      t.boolean :product_save_notify
      t.boolean :mentions_notify
      t.boolean :publish_fb

      t.timestamps
    end
    add_index :user_settings, :user_id
  end
end
