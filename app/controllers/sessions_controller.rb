class SessionsController < ApplicationController
  def new
  end

  def create 
    @current_user = User.find_by_username(user_params["username"])

    if username_not_recognised?
      flash[:warning] = "The username #{user_params["username"]} does not exist"
      redirect_to new_sessions_url
    elsif failed_password_authentication?(user_params["password"])
      flash[:warning] = "Username and password do not match, please try again"
      redirect_to new_sessions_url
    else
      session[:current_user_id] = @current_user.id
      redirect_to posts_url
    end
  end
  
  def destroy
    session.delete(:current_user_id)
    flash[:notice] = "Successfully signed out"
    redirect_to new_sessions_url
  end

  private

  def user_params
    params.require(:username)
    params.require(:password)
    params.permit(:username, :password)
  end

  def failed_password_authentication?(password)
    (@current_user.authenticate(user_params["password"])) == false
  end

  def username_not_recognised?
    @current_user.nil?
  end
end
