require 'rails_helper'

RSpec.describe Api::V1::UsersController do 

  describe "POST #create" do
    context "valid user" do 
      before do 
        user = create_user(username: "camlogie", full_name: "Cam Logie", email: "cam@cam.com", password: "password")
        post_user(user)
      end

      it 'returns true' do
        expect(JSON.parse(response.body)).to eq(true)
      end

      it 'returns a created status' do
        expect(response).to have_http_status(:created)
      end

    end

    context "invalid email" do 
      before do
        user = create_user(username: "camlogie", full_name: "Cam Logie", email: "camcamcam", password: "password")
        post_user(user)
      end
      it 'returns error' do
        expect(response).to have_http_status(:error)
        json = JSON.parse(response.body)
        expect(json['error']).to eq "Email invalid"
      end
    end

  end

end
