module Api
  module V1
    class PostsController < ApiController
      before_action :check_basic_auth
      before_action :find_post, only: [:show, :update, :destroy]

      def index
        @posts = Post.order(created_at: :desc)
        @user = current_user
        # this is required for the tests but for production: @current_user could be used in views
        render('/api/v1/posts/index.json.jbuilder')
      end

      def show
        @post 
        @user = current_user
        # by assigning @user to current_user - enables test to stub current user method and that
        # user to then be used in the json builder views
        render('/api/v1/posts/show.json.jbuilder')
      end

      def create
        @post = Post.create(message: post_params["message"], user_id: current_user.id)
        if @post
          render json: @post, status: 201
        else
          render error: { error: 'Unable to create post.' }, status: 400
        end
      end

      def update
        if @post
          @post.update(post_params) 
          render json: { message: 'Post successfully updated' }, status: 200
        else
          render error: { error: 'Unable to update post' }, status: 400
        end
      end
      
      def destroy
        if @post
          @post.destroy
          render json: { message: 'Post successfully deleted' }, status: 200
        else
          render error: { error: 'Unable to delete post' }, status: 400
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