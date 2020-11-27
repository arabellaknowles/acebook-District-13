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
      expect(json).to eq true
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

  describe 'Sessions#Destroy' do
    
    it 'returns a successful message when the session is deleted' do 
      post '/api/v1/sessions', params: { username: 'camlogie', password: 'password' }
      delete '/api/v1/sessions'
      expect(response).to have_http_status(200) 
      json = JSON.parse(response.body)
      expect(json["message"]).to eq "Successfully logged out"
    end

    it 'returns an error when trying to delete a session that was never created' do
      delete '/api/v1/sessions' 
      expect(response).to have_http_status(500)
      json = JSON.parse(response.body)
      expect(json["error"]).to eq "You are not signed in"
    end

  end

end