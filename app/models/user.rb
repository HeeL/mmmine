class User < ActiveRecord::Base
  devise :database_authenticatable, :validatable, :omniauthable, :rememberable, :trackable

  attr_accessible :about, :email, :location, :name, :password, :photo,
                  :provider, :uid, :website, :password_confirmation, :remember_me

  validates :name, presence: true, length: {in: 3..30}

  def self.find_fb_user(auth)
    user = User.where(provider: auth.provider, uid: auth.uid).first
    if !user
      user = User.new(
        name: auth.extra.raw_info.name,
        email: auth.info.email,
        password: Devise.friendly_token[0,10]
      )
      user.provider = auth.provider
      user.uid = auth.uid
      user.save
    end
    user
  end

  def remember_me
    true  
  end

end
