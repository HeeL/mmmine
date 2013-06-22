class CreateUserSettings < ActiveRecord::Migration
  def change
    create_table :user_settings do |t|
      t.references :user
      t.boolean :new_follower_notify, default: true
      t.boolean :product_save_notify, default: true
      t.boolean :mentions_notify, default: true
      t.boolean :publish_fb, default: true

      t.timestamps
    end
    add_index :user_settings, :user_id
  end
end
