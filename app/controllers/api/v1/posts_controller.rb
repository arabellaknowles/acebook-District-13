module Api
  module V1
    class PostsController < ApiController
      before_action :check_basic_auth, :find_post

      def index
        @posts = Post.order(created_at: :desc)
      end
      def show
        @post = Post.find(params[:id])
      end
      def create
        @post = Post.create(message: post_params["message"], user_id: @current_user.id)
        if @post
          render json: @post
        else
          render error: { error: 'Unable to create post.' }, status: 400
        end
      end
      def update
        if @post
          @post.update(post_params) 
          render json: { message: 'Fact successfully updated' }, status: 200
        else
          render error: { error: 'Unable to update fact' }, status: 400
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