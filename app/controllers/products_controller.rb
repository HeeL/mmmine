class ProductsController < ApplicationController
  
  before_filter :authenticate_user!, except: :index
  before_filter :show_sidebar, only: [:index, :live_feed]


  def index
    @products = Product.page(params[:page]).per(18)
    ajax_products if request.xhr?
  end

  def live_feed
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

  def ajax_products
    if @products.blank?
      render text: ''
    else
      render layout: false
    end
  end

end
