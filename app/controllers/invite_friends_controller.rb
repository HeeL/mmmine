class InviteFriendsController < ApplicationController

  def index
  end

  def send_emails
    render(text: '') && return unless params[:email]
    params[:email].each do |k, email|
      InviteMailer.send_invitation(email, current_user).deliver if email.present?
    end
  end

end