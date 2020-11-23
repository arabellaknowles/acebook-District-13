module Api
  module V1
    class PostsController < ApiController
      before_action :check_basic_auth

      def index
        @posts = Post.order(created_at: :desc)
      end
      def show
        @post = Post.find(params[:id])
      end
      def create
        p post_params["message"]
        p @current_user.id
        @post = Post.create(message: post_params["message"], user_id: @current_user.id)
        
        
        # if @post
        #   render json: @post
        # else
        #   render error: { error: 'Unable to create post.' }, status: 400
        # end
      end
      def update

      end


      private 

      def post_params
        params.require(:message)
        params.permit(:message)
      end
    end
  end
end