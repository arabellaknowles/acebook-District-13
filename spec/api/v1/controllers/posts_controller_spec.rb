require 'rails_helper'

RSpec.describe Api::V1::PostsController do 

  describe "POST #create" do
    before do
      post_user = instance_double("User", 
      username: "arabellsy", 
      email: "araknwlo@gmail.com", 
      full_name: "A Dog", 
      password: "adoggle",
      id: 1)  

      allow_any_instance_of(Api::V1::PostsController).to receive(:check_basic_auth).and_return(post_user)
      allow_any_instance_of(Api::V1::PostsController).to receive(:current_user).and_return(post_user)
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
end