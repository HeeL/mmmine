class User < ActiveRecord::Base
  devise :database_authenticatable, :validatable, :omniauthable, :rememberable, :trackable

  attr_accessible :about, :email, :location, :name, :password, :photo, :user_setting_attributes,
  :provider, :uid, :website, :password_confirmation, :remember_me

  has_one :user_setting, :dependent => :destroy
  has_many :products
  has_many :comments

  has_attached_file :photo, :styles => { 
    :photo => "140x120#",
    :avatar => "32x32#"
  }, 
  :default_url => '/assets/missing_photo/:style.png'

  validates :name, presence: true, length: {in: 3..30}
  validates :location, presence: true

  accepts_nested_attributes_for :user_setting

  acts_as_followable
  acts_as_follower

  def self.find_fb_user(auth)
    user = User.where(provider: auth.provider, uid: auth.uid).first
    if !user
      photo = open("http://graph.facebook.com/#{auth.uid}/picture?type=large") rescue nil
      location = auth.info.location.present? ? auth.info.location : 'No Location Set'
      user = User.new(
        name: auth.info.nickname,
        email: auth.info.email,
        location: location,
        password: Devise.friendly_token[0,10],
        photo: photo
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

  def self.match_names(name, exact = false)
    name = exact ? name : "%#{name}%"
    self.where('name ILIKE ?', name).limit(5).all.map(&:name) 
  end

end
