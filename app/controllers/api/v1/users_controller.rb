module Api
  module V1
    class UsersController < ApiController
      
      def new
        @user = User.new
      end

      def create 
        if User.email_and_username_in_use?(user_params["username"], user_params["email"])
          render error: { error: 'Username and email in use' }, status: 400
        elsif User.email_in_use?(user_params["email"])
          render error: { error: 'Email in use' }, status: 400
        elsif User.username_in_use?(user_params["username"])
          render error: { error: 'Username in use' }, status: 400
        elsif !User.valid_email?(user_params["email"])
          render error: { error: 'Email invalid' }, status: 400    
        elsif !User.valid_password?(user_params["password"])
          render error: { error: 'Password invalid' }, status: 400
        else
          @user = User.create(user_params)
          session[:current_user_id] = @user.id
          render json: session[:current_user_id]
        end
      end

      private

      def user_params
        params.require(:username)
        params.require(:email)
        params.require(:password)
        params.require(:full_name)
        params.permit(:username, :full_name, :email, :password)
      end
    end
  end
end