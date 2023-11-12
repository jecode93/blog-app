class PostsController < ApplicationController
  def index
    @user = User.find(params[:user_id])
    # retrieve posts associated to @user and
    # eager-loading the associated comments
    @posts = @user.posts.includes(comments: [:user])
  rescue ActiveRecord::RecordNotFound
    # Handle the case where the user is not found
    # Redirect to the root page
    flash[:error] = 'User not found.'
    redirect_to root_path
  end

  def show
    @user = User.find(params[:user_id])
    # retrieve the post associated to @user and
    # eager-loading the associated comments
    @post = @user.posts.includes(:comments).find(params[:id])
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(params.require(:post).permit(:title, :text))
    @post.author = current_user
    if @post.save
      flash[:success] = 'Post created successfully!'
      redirect_to user_posts_url
    else
      flash.now[:error] = 'Error: Post could not be created!'
      render :new, locals: { post: @post }
    end
  end
end
