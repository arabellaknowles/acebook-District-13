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
          render json: {
            valid: true,
            user: {id: @user.id, username: @user.username},
            token: issue_token(@user)
          }, status: 201
        end
      end

      def destroy 

      end

      def authorize
        if logged_in? 
          render json: { valid: true }, status: 200
        else
          render json: { valid: false }, status: 401
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