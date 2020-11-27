module Api
  module V1
    class PostsController < ApiController
      before_action :find_post, only: [:show, :update, :destroy]

      def index
        if logged_in?
          @user_id = current_user.id
        else
          @user_id = nil
        end
        @posts = Post.order(created_at: :desc)
        p @posts
        render('/api/v1/posts/index.json.jbuilder')
      end

      def show
        @post 
        @user = current_user
        render('/api/v1/posts/show.json.jbuilder')
      end

      def create
        @post = Post.create(message: post_params["message"], user_id: current_user.id)
          render json: @post, status: 201
      end

      def update
        if @post.editable?(current_user.id)
          @post.update(post_params) 
          render json: { message: 'Post successfully updated' }, status: 200
        else
          render json: { error: 'Unable to update post' }, status: 500
        end
      end
      
      def destroy
        if @post.owned_by?(current_user.id)
          @post.destroy
          render json: { message: 'Post successfully deleted' }, status: 200
        else
          render json: { error: 'Unable to delete post' }, status: 500
        end
      end

      private 

      def post_params
        params.require(:message)
        params.permit(:message)
      end

      def find_post
        @post = Post.find(params[:id])
      end
    end
  end
end
