require 'rails_helper'

RSpec.describe Api::V1::SessionsController do

  before do 
    User.create(
      username: 'camlogie',
      full_name: 'Cam Logie',
      email: 'camlogie@gmail.com',
      password: 'password'
    )
  end

  describe 'Sessions#Create' do

    it 'returns true when a session is created successfully' do
      post '/api/v1/sessions', params: { username: 'camlogie', password: 'password' }
      expect(response).to have_http_status(:created)
      json = JSON.parse(response.body)
      expect(json["valid"]).to eq true
    end

    it 'returns an error when an unrecognized username is provided by the user' do
      post '/api/v1/sessions', params: { username: 'camLog', password: 'password'} 
      expect(response).to have_http_status(:error)
      json = JSON.parse(response.body)
      expect(json["error"]).to eq "The username camLog does not exist"
    end

    it 'returns an error when the provided password does not match with the associated username' do
      post '/api/v1/sessions', params: { username: 'camlogie', password: 'npassword' }
      expect(response).to have_http_status(:error)
      json = JSON.parse(response.body)
      expect(json["error"]).to eq "Username and password do not match, please try again"
    end

  end

end
