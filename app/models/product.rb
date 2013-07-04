class Product < ActiveRecord::Base

  default_scope order('created_at desc')

  attr_accessible :url, :picture, :user

  belongs_to :user

  has_many :comments

  has_attached_file :picture, :styles => { 
    big: "620x",
    middle: "217x"
  }

  validates :url, presence: true

  def self.create_by_url(url, user)
    self.create(
      user: user,
      url: url,
      picture: open(url)
    )
  end

end