class Comment < ActiveRecord::Base

  default_scope order('created_at desc')

  attr_accessible :text, :user, :product

  belongs_to :user
  belongs_to :product

  validates :text, presence: {message: 'You have to write something'}

end