class ProductsController < ApplicationController
  
  before_filter :authenticate_user!, except: :index
  before_filter :show_sidebar, only: [:index, :live_feed]
  before_filter :find_product, only: [:destroy, :buy, :follow]


  def index
    @product_list_options = {
      classes: 'content row3 products_list',
      path: product_list_path(desc: params[:desc], order: params[:order], sub_category_id: params[:sub_category_id])
    }
    product = Product
    if params[:sub_category_id]
      product = product.where(sub_category_id: params[:sub_category_id])
    end
    if params[:order] && ['followed'].include?(params[:order])
      product = product.unscoped.order("#{params[:order]} #{'DESC' if params[:desc]}");
    end
    @products = get_product_list(product, @product_list_options)
  end

  def live_feed
    @product_list_options = {
      classes: 'content row3 products_list',
      path: live_feed_path
    }
    products = Product.where(user_id: current_user.following_users.map(&:id))
    @products = get_product_list(products, @product_list_options)
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
    end
    @product.save
  end

  private

  def find_product
    @product = Product.find(params[:id])
  end

  def show_sidebar
    @right_section = true
  end

end
