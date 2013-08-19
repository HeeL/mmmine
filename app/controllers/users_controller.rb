class UsersController < ApplicationController

  before_filter :authenticate_user!, except: [:login, :register, :show]
  before_filter :follow_info, only: :follow
  before_filter :find_user, only: :show


  def show
    @product_list_options = {
      classes: 'content row4 nomargin products_list',
      path: show_profile_path(id: @user.id)
    }
    get_product_list(@user.products, @product_list_options)
  end
    
  def edit
    return unless params[:user]
    if !current_user.update_attributes(params[:user])
      flash[:error] = current_user.errors.full_messages.first
    else
      flash[:notice] = 'Profile was updated'
    end
    render 'edit'
  end

  def change_password
    if current_user.valid_password?(params[:old_password])
      current_user.update_attributes(password: params[:new_password])
      sign_in(current_user, bypass: true)
      result = set_success
    else
      result = set_error("The old password is not correct")  
    end
    render json: result
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

  def follow
    @follow = current_user.following?(@follow_user)
    if @follow
      current_user.stop_following(@follow_user)
    else
      current_user.follow(@follow_user)
    end
  end

  private

  def follow_info
    if params[:product_id]
      product = Product.find(params[:product_id])
      @follow_user = product.user
      @product_id = product.id
    else
      @product_id = ''
      @follow_user = User.find(params[:user_id])
    end
  end

  def find_user
    @user = params[:id] ? User.find(params[:id]) : current_user
  end

end
