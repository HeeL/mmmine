class Notification < ActiveRecord::Base
  attr_accessible :from_user_id, :to_user_id, :action, :item_id

  ACTIONS = [:follow_user, :share_product, :follow_product, :comment_product, :mention_user]

  belongs_to :user, foreign_key: :from_user_id

  scope :my, ->(user_id) { where(to_user_id: user_id).order('created_at DESC').limit(25) }

  alias_method :from_user, :user

  def self.add(data, action)
    return false unless action_id = ACTIONS.index(action)
    create(data.merge(action: action_id))
  end

end
