class Product < ActiveRecord::Base

  default_scope order('created_at desc')

  attr_accessible :url, :user, :price, :description, 
    :size, :currency, :title

  belongs_to :user

  has_many :comments, dependent: :destroy
  has_many :product_pictures, dependent: :destroy

  validates :price, presence: true
  validates :description, presence: true

  def main_picture
    (product_pictures.first || ProductPicture.new).picture(:middle)
  end

end