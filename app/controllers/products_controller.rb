class ProductsController < ApplicationController
  
  before_filter :authenticate_user!

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

end
