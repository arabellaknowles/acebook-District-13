class PostsController < ApplicationController
  def new
    redirect_if_not_logged_in
    @post = Post.new
  end

  def create
    @post = Post.create(message: post_params["message"], user_id: session[:current_user_id])
    redirect_to posts_url
  end

  def edit
    redirect_if_not_logged_in
    @post = Post.find_by_id(params[:id])
  end

  def update
    @post = Post.find_by_id(params[:id])

    flash[:warning] = "Error: You can only update posts when they are less than 10 minutes old" unless @post.is_less_than_ten_minutes_old?
    flash[:warning] = "Error: You can only edit your own posts." unless @post.owned_by(current_user.id)
    @post.update(message: post_params["message"]) if @post.editable?(current_user.id)
   
    redirect_to posts_url
  end

  def index
    redirect_if_not_logged_in
    @posts = Post.order(created_at: :desc)
    @current_user = current_user
  end

  private

  def redirect_if_not_logged_in
    redirect_to new_sessions_url if current_user.nil?
  end

  def post_params
    params.require(:post).permit(:message)
  end

  def current_user
    @current_user ||= User.find(session[:current_user_id]) if session[:current_user_id]
  end

end
