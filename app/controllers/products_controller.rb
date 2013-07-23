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
    @product = current_user.products.new(get_product_info)
    if @product.save
      result = set_success
      result.merge!(new_product)
      result.merge!(product_id: @product.id)
    else
      result = set_error('Please complete all the fields')  
    end
    render json: result
  end

  def new_product
    {
      new_product:
        render_to_string('/products/_product_details',
          locals: {product: @product},
          layout: false
        )
    }
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

  def ajax_products
    if @products.blank?
      render text: ''
    else
      render layout: false
    end
  end

end
