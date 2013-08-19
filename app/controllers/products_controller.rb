class ProductsController < ApplicationController
  
  before_filter :authenticate_user!, except: :index
  before_filter :show_sidebar, only: [:index, :live_feed]


  def index
    @product_list_options = {
      classes: 'content row3 products_list',
      path: product_list_path
    }
    @products = get_product_list(Product, @product_list_options)
  end

  def live_feed
    @product_list_options = {
      classes: 'content row3 products_list',
      path: live_feed_path
    }
    products = Product.where(user_id: current_user.all_following.map(&:id))
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
    product = Product.find(params[:id])
    authorize! :destroy, product
    product.destroy

    redirect_to live_feed_path
  end

  private

  def show_sidebar
    @right_section = true
  end

end
