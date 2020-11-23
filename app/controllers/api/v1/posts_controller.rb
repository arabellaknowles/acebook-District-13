module Api
  module V1
    class PostsController < ApiController
      def index
        @posts = Post.order(created_at: :desc)
        # @posts = Post.all.paginate(page: params[:page]) (page of posts)
        # install will_paginate gem 
      end
      def show
        @post = Post.find(params[:id])
      end
    end
  end
end