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

      PostsController.instance_variable_set(:@current_user, post_user)
      # post_user(user)
      # current_user = User.find_by_email("cam@cam.com")
      # p current_user
      allow_any_instance_of(Api::V1::PostsController).to receive(:check_basic_auth).and_return(post_user)
      post '/api/v1/posts', params: { message: "hello" }
    end

    it 'returns the post' do
      p response.body
      expect(JSON.parse(response.body["message"])).to eq("hello")
    end
  end
end