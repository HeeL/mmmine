class ApplicationController < ActionController::Base
  protect_from_forgery

  PER_PAGE = 24

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_url, :error => exception.message
  end


  def set_success(text = '')
    {status: 'success', text: text}
  end

  def set_error(text)
    {status: 'error', text: text}
  end

  def get_product_list(products, options = {})
    product_list = products.page(params[:page]).per(PER_PAGE)
    ajax_products(product_list, options) if request.xhr?
    product_list
  end

  private

  def ajax_products(products, options)
    if products.blank?
      render text: ''
    else
      render partial: 'shared/product_list', locals: {products: products}.merge(options)
    end
  end

end
