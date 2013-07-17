class CommentsController < ApplicationController
  
  before_filter :authenticate_user!


  def create
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

end