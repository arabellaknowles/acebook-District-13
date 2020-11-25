require 'rails_helper'

RSpec.describe Api::V1::PostsController do 
  before do
    post_user = instance_double("User", 
    username: "arabellsy", 
    email: "araknwlo@gmail.com", 
    full_name: "A Dog", 
    password: "adoggle",
    id: 1)  

    allow_any_instance_of(Api::V1::PostsController).to receive(:check_basic_auth).and_return(post_user)
    allow_any_instance_of(Api::V1::PostsController).to receive(:current_user).and_return(post_user)
  end

  describe "POST #create" do
    before do 
      post '/api/v1/posts', params: { message: "hello" }
    end

    it 'returns the post' do
      json = JSON.parse(response.body)
      expect(json["message"]).to eq("hello")
    end

    it 'returns a created status' do
      expect(response).to have_http_status(:created)
    end
  end

  describe "GET #show" do
    before do
      User.create(id: 1, username: 'AD0G', full_name: 'Azza Kno', password: 'binupx3', email: 'dogz@makers.com' )
      Post.create(id: 1, message: "Dogs over cats, sue me", user_id: 1)
      p Post.all
    end

    it 'returns the post' do
      get '/api/v1/posts/1'
      expect(response).to eq("Dogs over cats, sue me")
      # currently failing as there is no template for the show method
    end
  end
end