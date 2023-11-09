class CommentsController < ApplicationController
  def new
    @comment = Comment.new
  end

  def create
    @comment = Comment.new(comments_param)
    @comment.user = current_user
    if @comment.save
      flash[:success] = 'Comment created successfully!'
      redirect_to user_post_path(id: @comment.post_id, user_id: @comment.user_id)
    else
      flash.now[:error] = 'Error: Comment could not be created!'
      render :new, locals: { comment: @comment }
    end
  end

  private

  def comments_param
    params.require(:comment).permit(:text, :user_id, :post_id)
  end
end
