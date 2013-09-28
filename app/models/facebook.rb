class Facebook

  def initialize(access_token)
    @fb_user = FbGraph::User.me(access_token)
  end

  def friends(name = false, limit = false)
    friends = []
    @fb_user.friends.each do |friend|
      if !name || (name && friend.name.match(/#{name}/i))
        friends << {
          id: friend.identifier,
          name: friend.name,
          nickname: (JSON.parse(`curl "https://graph.facebook.com/#{friend.identifier}"`)['username'] rescue '')
        }
      end
      break if limit && friends.count >= limit
    end
    friends
  end

  def self.get_access_token(code, redirect_path)
    access_token = false
    fb_response = `curl "https://graph.facebook.com/oauth/access_token?client_id=#{ENV['FACEBOOK_APP_ID']}&redirect_uri=http://#{ENV['SITE_URL']}#{redirect_path}&client_secret=#{ENV['FACEBOOK_APP_SECRET']}&code=#{code}"`
    if fb_response.match(/access_token\=/)
      access_token = fb_response.match(/\=(.+?)&/)[1] rescue false
    end
    access_token
  end

  def self.get_code_url(redirect_path, scope)
    "https://www.facebook.com/dialog/oauth?redirect_uri=http://#{ENV['SITE_URL']}#{redirect_path}&scope=#{scope}&app_id=#{ENV['FACEBOOK_APP_ID']}"
  end
  
end
