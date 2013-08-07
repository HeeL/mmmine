class RemovePictureFromProduct < ActiveRecord::Migration
  def up
    remove_column :products, :picture_file_name
    remove_column :products, :picture_content_type
    remove_column :products, :picture_file_size
    remove_column :products, :picture_updated_at
  end
end
