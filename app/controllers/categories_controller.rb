class CategoriesController < ApplicationController
  
  include ActionView::Helpers::FormOptionsHelper
  
  def sub_cats
    @subs = Category.find(params[:id]).sub_categories
    render layout: false
  end

end