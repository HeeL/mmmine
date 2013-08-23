class Product < ActiveRecord::Base

  default_scope order('created_at desc')

  attr_accessible :user, :price, :description, :size, :currency,
                  :title, :category_id, :sub_category_id, :sold_to

  belongs_to :user
  belongs_to :category
  belongs_to :sub_category

  has_many :comments, dependent: :destroy
  has_many :product_pictures, dependent: :destroy

  validates :price, :description, :size, :currency, :title, presence: true

  acts_as_followable


  def main_picture
    (product_pictures.first || ProductPicture.new).picture(:middle)
  end

  def sold?
    self.sold_to > 0
  end

end