class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.string :password
      t.string :provider
      t.string :uid
      t.string :location
      t.string :website
      t.string :about
      t.attachment :photo
      
      t.timestamps
    end
  end
end
