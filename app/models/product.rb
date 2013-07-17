class Product < ActiveRecord::Base

  default_scope order('created_at desc')

  attr_accessible :url, :picture, :user, :price, :description

  belongs_to :user

  has_many :comments

  has_attached_file :picture, :styles => { 
    big: "620x",
    middle: "217x"
  }

  validates :url, presence: true
  validates :price, presence: true
  validates :description, presence: true

end