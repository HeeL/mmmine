class ProductPicture < ActiveRecord::Base

  belongs_to :product

  attr_accessible :picture

  has_attached_file :picture, styles: { 
    big: "620x",
    middle: "217x",
    small: '80x'
  },
  default_url: '/assets/missing_photo/photo.png'

end