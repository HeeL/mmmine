class CommentsController < ApplicationController
  
  before_filter :authenticate_user!


  def create
    @comment = current_user.comments.create(
      text: params[:text],
      product: Product.find(params[:product_id])
    )
  end

  def destroy
    @comment = Comment.find(params[:id])
    authorize! :destroy, @comment
    @comment.destroy
  end

end