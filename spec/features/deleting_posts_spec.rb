require 'rails_helper'

RSpec.feature "Deleting posts", type: :feature do

  context 'User is Signed up and Post is created before tests' do
    
    before do
      user_signup('arakno', 'arakno@makers.com', 'Arabella Knowles', 'makers4L')
      create_post("Hello, world!")
    end

    scenario 'User can delete their post when pressing delete button' do
      click_link('delete')
      expect(page).to_not have_content('Hello, world!')
    end

    scenario 'Different logged in user cannot see delete button for posts that do not belong to them' do
      click_link('Logout')
      user_signup('cam', 'cam@cam.com', 'Cam Cam', 'password')
      expect(page).to_not have_link('delete')
    end
  end

end

