module Api
  module V1
    class ApiController < ApplicationController

      private

      def check_basic_auth
        unless request.authorization.present?
          head :unauthorized
          return
        end
        authenticate_with_http_basic do |username, password|
          user = User.find_by(username: username)
          if user && user.authenticate(password)
            @current_user = user
          else
            head :unauthorized
          end
        end
      end

      def current_user
        @current_user
      end

    end
  end
end