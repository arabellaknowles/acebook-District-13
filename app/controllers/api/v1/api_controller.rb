module Api
  module V1
    class ApiController < ApplicationController
      skip_before_action :verify_authenticity_token

      private

      def jwt_key
        ENV['SESSION_SECRET']
      end

      def issue_token(user)
        JWT.encode({user_id: user.id}, jwt_key, 'HS256')
      end

      def decoded_token
        p 'start'
        p token
        begin
          JWT.decode(token, jwt_key, true, { :algorithm => 'HS256' })
        rescue JWT::DecodeError
          [{error: "Invalid Token"}]
        end
      end

      def token
        p request.headers
        request.headers['Authorization']
      end

      def user_id
        p 'token'
        p decoded_token
        decoded_token.first['user_id']
      end

      def current_user
        p 'api-c-user_id'
        p user_id
        user ||= User.find_by(id: user_id)
      end

      def logged_in?
        !!current_user
      end
    end
  end
end