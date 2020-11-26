module Api
  module V1
    class SessionsController < ApiController
      def create
        @user = User.find_by_username(user_params["username"])

        if username_not_recognised?
          render json: { error: "The username #{user_params['username']} does not exist" }, status: 500
        elsif failed_password_authentication?(user_params["password"])
          render json: { error: "Username and password do not match, please try again" }, status: 500
        else
          session[:current_user_id] = @user.id
          render json: true, status: 201
        end
      end

      def destroy 
        if !session[:current_user_id]
          render json: { error: "You are not signed in"}, status: 500
        else
          session.delete(:current_user_id)
          render json: { message: 'Successfully logged out'}, status: 200
        end
      end

      private

      def user_params
        params.require(:username)
        params.require(:password)
        params.permit(:username, :password)
      end

      def failed_password_authentication?(password)
        (@user.authenticate(user_params["password"])) == false
      end
    
      def username_not_recognised?
        @user.nil?
      end
    end
  end
end