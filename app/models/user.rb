class User < ActiveRecord::Base
  devise :database_authenticatable, :validatable, :omniauthable, :rememberable, :trackable

  attr_accessible :about, :email, :location, :name, :password, :photo, :user_setting_attributes,
                  :provider, :uid, :website, :password_confirmation, :remember_me

  has_one :user_setting, :dependent => :destroy

  has_attached_file :photo, :styles => { :photo => "140x120>", :avatar => "32x32>" }

  validates :name, presence: true, length: {in: 3..30}

  accepts_nested_attributes_for :user_setting

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
