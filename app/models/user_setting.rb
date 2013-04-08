class UserSetting < ActiveRecord::Base
  belongs_to :user
  attr_accessible :mentions_notify, :new_follower_notify, :product_save_notify, :publish_fb
end
