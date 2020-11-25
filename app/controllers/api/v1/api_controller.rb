module Api
  module V1
    class ApiController < ApplicationController
      skip_before_action :verify_authenticity_token

      private

      def check_basic_auth
        if !!session[:current_user_id]
          @current_user = User.find(session[:current_user_id])
        else
          head :unauthorized
          return
        end
      end

      def current_user
        @current_user
      end
    end
  end
end