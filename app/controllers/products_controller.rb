class ProductsController < ApplicationController
  
  before_filter :authenticate_user!, except: :index

  before_filter :show_sidebar, only: [:index, :live_feed]

  def create
    product = current_user.products.new(get_product_info)
    if product.save
      result = set_success
    else
      result = set_error(product.errors.full_messages.first)  
    end
    render json: result
  end

  def index
    @products = Product.limit(9)
  end

  def live_feed
  end

  def comment_create
    if params[:text].blank?
      result = set_error("You have to write something")  
    elsif add_comment.persisted?
      result = set_success
      result.merge!(new_comment)
    else
      result = set_error("We have failed to post your comment")  
    end
    render json: result
  end

  private

  def new_comment
    {
      new_comment:
        render_to_string('/products/comments/_comment',
          locals: {comment: @comment},
          layout: false
        )
    }
  end

  def add_comment
    @comment = Comment.create(
      user: current_user,
      text: params[:text],
      product: Product.find(params[:product_id])
    )
  end

  def get_product_info
    if params[:product][:url].to_s.match(/http\:\/\/.+/)
      params[:product].merge!(picture: open(params[:product].try(:[],:url)))
    end
    params[:product]
  end

  def show_sidebar
    @right_section = true
  end

end
