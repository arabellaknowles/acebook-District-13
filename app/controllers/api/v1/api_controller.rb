module Api
  module V1
    class ApiController < ApplicationController
      skip_before_action :verify_authenticity_token

      private

      def check_basic_auth
        p session[:current_user_id]
        if session[:current_user_id].nil?
          head :unauthorized
          return
        else
          @current_user = User.find(session[:current_user_id])
        end
      end

      def current_user
        @current_user
      end

    end
  end
end