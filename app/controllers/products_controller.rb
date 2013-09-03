class ProductsController < ApplicationController
  
  before_filter :authenticate_user!, except: :index
  before_filter :show_sidebar, only: [:index, :live_feed, :top_stores]
  before_filter :find_product, only: [:destroy, :buy, :follow]

  SEARCH_KEYS = [:desc, :order, :sub_category_id, :things_i_want]

  def index
    list_products(product_conditions, product_list_path(list_params))
  end

  def live_feed
    products = Product.where(user_id: current_user.following_users.map(&:id))
    list_products(products, live_feed_path)
  end

  def top_stores
    @product_list_options = {
      classes: 'content row3 products_list',
      path: top_stores_path
    }
    user_ids = User.order('followed DESC').limit(10).map(&:id)
    @products = Product.unscoped.select('DISTINCT ON (user_id) *').where(user_id: user_ids)
    @products.sort!{|x,y| y.user.followed <=> x.user.followed}
  end

  def create
    @product = current_user.products.new(params[:product])
    if @product.valid? && params[:product_pictures].present?
      @product.save
      params[:product_pictures].each do |i, pic|
        @product.product_pictures.create(picture: pic)
      end
    end
  end

  def destroy
    authorize! :destroy, @product
    @product.destroy

    redirect_to live_feed_path
  end

  def buy
    @product.update_attributes(sold_to: current_user.id)
    PurchaseMailer.buyer(current_user, @product).deliver
    PurchaseMailer.seller(current_user, @product).deliver
  end

  def follow
    if @follow = current_user.following?(@product)
      current_user.stop_following(@product)
      @product.followed -= 1
    else
      current_user.follow(@product)
      @product.followed += 1
      add_comment
    end
    @product.save
  end

  private

  def product_conditions
    product = Product
    if params[:sub_category_id]
      product = product.where(sub_category_id: params[:sub_category_id])
    end
    if params[:things_i_want]
      product = User.find(params[:things_i_want]).following_products
    end
    if params[:order] && ['followed'].include?(params[:order])
      product = product.unscoped.order("#{params[:order]} #{'DESC' if params[:desc]}");
    end
    product
  end

  def list_products(products, path)
    @product_list_options = {
      classes: 'content row3 products_list',
      path: path
    }
    @products = get_product_list(products, @product_list_options)
  end

  def find_product
    @product = Product.find(params[:id])
  end

  def add_comment
    if params[:comment].present?
      @comment = current_user.comments.create(
        text: params[:comment],
        product: @product
      )
    end
  end

  def show_sidebar
    @right_section = true
  end

  def list_params
    keys = {}
    SEARCH_KEYS.each do |key|
      keys[key] = params[key]
    end
    keys
  end

end
