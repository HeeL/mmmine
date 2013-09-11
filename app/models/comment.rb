class Comment < ActiveRecord::Base

  default_scope order('created_at desc')

  attr_accessible :text, :user, :product

  belongs_to :user
  belongs_to :product

  validates :text, presence: {message: 'You have to write something'}

  before_save :notify


  def notify
    Notification.add(
      { 
        from_user_id: self.user.id,
        to_user_id:   self.product.user.id,
        item_id:      self.product.id
      },
      :comment_product
    )
  end

end