class InviteFriendsController < ApplicationController

  before_filter :get_fb_access


  def index
  end

  def send_emails
    render(text: '') && return unless params[:email]
    params[:email].each do |k, email|
      InviteMailer.send_invitation(email, current_user).deliver if email.present?
    end
  end

  def fb_friends
    @friends = Facebook.new(session[:fb_access_token]).friends(params[:name], 6)
  end

  private

  def get_fb_access
    if params[:code]
      session[:fb_access_token] = Facebook.get_access_token(params[:code], '/invite_friends')
    end
    if !session[:fb_access_token]
      redirect_to Facebook.get_code_url('/invite_friends', 'read_friendlists,publish_actions')
    end
  end

end
