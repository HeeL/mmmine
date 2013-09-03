class AddFollowedToUsers < ActiveRecord::Migration
  def change
    change_table :users do |t|
      t.integer :followed, default: 0
    end
  end
end
