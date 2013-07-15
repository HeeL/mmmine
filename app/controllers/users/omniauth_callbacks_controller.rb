class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController

  def facebook
    @user = User.find_fb_user(request.env["omniauth.auth"])
    login('Facebook')
  end
  
  private

  def login(provider)
    if @user.persisted?
      session["devise.#{provider.downcase}_data"] = request.env["omniauth.auth"]
      flash[:notice] = I18n.t "devise.omniauth_callbacks.success", kind: provider
      sign_in @user, event: :authentication
      redirect_user(@user)
    else
      flash[:error] = "We've failed to log you in"
      redirect_to root_path
    end
  end

  def redirect_user(user)
    if user.sign_in_count > 1
      redirect_to live_feed_path
    else
      redirect_to edit_profile_path
    end
  end
end