class Product < ActiveRecord::Base

  default_scope order('created_at desc')

  attr_accessible :url, :user, :price, :description, 
    :size, :currency, :title, :category_id, :sub_category_id

  belongs_to :user
  belongs_to :category

  has_many :comments, dependent: :destroy
  has_many :product_pictures, dependent: :destroy

  validates :price, presence: true
  validates :description, presence: true

  def main_picture
    (product_pictures.first || ProductPicture.new).picture(:middle)
  end

end