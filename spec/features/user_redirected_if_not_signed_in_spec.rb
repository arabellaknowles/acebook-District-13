require 'rails_helper'

feature 'User redirected if not signed in' do
  before do
    user_signup('arakno', 'dan@makers.com', 'Arabella Knowles', 'makers4L')
    create_post('Hello, world!')
    click_link 'Logout'
  end

  scenario 'User visits /posts/new' do
    visit '/posts/new'
    expect(current_path).to eq new_sessions_path
  end

  scenario 'User visits /posts/:id/edit' do
    post_id = Post.find_by(message: "Hello, world!").id
    visit "/posts/#{post_id}/edit"
    expect(current_path).to eq new_sessions_path
  end
end