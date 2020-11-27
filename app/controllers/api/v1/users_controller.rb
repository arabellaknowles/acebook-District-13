module Api
  module V1
    class UsersController < ApiController

      def create 
        if User.email_and_username_in_use?(user_params["username"], user_params["email"])
          render json: { error: 'Username and email in use' }, status: 500
        elsif User.email_in_use?(user_params["email"])
          render json: { error: 'Email in use' }, status: 500
        elsif User.username_in_use?(user_params["username"])
          render json: { error: 'Username in use' }, status: 500
        elsif !User.valid_email?(user_params["email"])
          render json: { error: 'Email invalid'}, status: 500
        elsif !User.valid_password?(user_params["password"])
          render json: { error: 'Password invalid' }, status: 500
        else
          @user = User.create(user_params)
          render json: {
            valid: true,
            user: {id: @user.id, username: @user.username},
            token: issue_token(@user)
          }, status: 201
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