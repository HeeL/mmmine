class UsersController < ApplicationController

  before_filter :authenticate_user!, except: [:login, :register]
    
  def edit
    return unless params[:user]
    if !current_user.update_attributes(params[:user])
      flash[:error] = current_user.errors.full_messages.first
    else
      flash[:notice] = 'Profile was updated'
    end
    render 'edit'
  end

  def logout
    sign_out current_user
    flash[:notice] = 'Signed out successfully'
    redirect_to root_path
  end

  def login
    user = User.where(email: params[:email].to_s.downcase).first
    if !user
      result = set_error("We don't have a user with such email")
    elsif !user.valid_password?(params[:password])
      result = set_error("The password is not correct")
    else
      sign_in user
      result = set_success
    end
    render json: result
  end

  def register
    user = User.create(
      email: params[:email],
      password: params[:password], 
      name: params[:name]
    )
    if user.persisted?
      sign_in user
      result = set_success
    else
      result = set_error(user.errors.full_messages.first)
    end
    render json: result
  end

end
