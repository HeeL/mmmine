class ProductsController < ApplicationController
  
  before_filter :authenticate_user!, except: :index

  def create
    if params[:url].blank?
      result = set_error("Fill the url field")  
    elsif Product.create_by_url(params[:url], current_user).persisted?
      result = set_success
    else
      result = set_error("We have failed to post your product")  
    end
    render json: result
  end

  def index
    @right_section = true
    @products = Product.limit(9)
  end

  def comment_create
    if params[:text].blank?
      result = set_error("You have to write something")  
    elsif add_comment.persisted?
      result = set_success
    else
      result = set_error("We have failed to post your comment")  
    end
    render json: result
  end

  private

  def add_comment
    Comment.create(
      user: current_user,
      text: params[:text],
      product: Product.find(params[:product_id])
    )
  end

end
