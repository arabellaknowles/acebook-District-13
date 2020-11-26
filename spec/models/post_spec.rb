require 'rails_helper'

RSpec.describe Post, type: :model do
  it { is_expected.to be }

  before do 
    User.create(id: 1, username: 'ds.danielh', full_name: 'Dan Holmes', password: 'hunter2', email: 'dan@makers.com' )
  end

  describe '.formatted_message' do
    it 'Retreives the message from the database and replaces line breaks with <br> tags.' do
      Post.create(id: 1, message: "Line 1\nLine 2", user_id: 1)
      expect(Post.find(1).formatted_message).to eq 'Line 1<br/>Line 2'
    end
  end

  describe '.editable?' do
    it 'returns true if the post at question is owned by the user and less than 10 minutes old' do
      post = Post.create(id: 1, message: 'I should be editable', user_id: 1)
      expect(Post.find(1).editable?(1)).to eq true
    end

    it 'returns false if the post at question is owned by the current user but more than 10 minutes old' do
      post = Post.create(id: 1, message: "I should not be editable", created_at: DateTime.now() - 10.minutes, user_id: 1)
      expect(Post.find(1).editable?(1)).to eq false
    end

    it 'returns false if the post at question is not owned by the current user but is less than 10 minutes old' do 
      new_user = User.create(id: 2, username: 'camlogie', full_name: 'Dan Holmes', password: 'hunter2', email: 'cam@makers.com' )
      post = Post.create(id: 1, message: 'I should not be editable', user_id: 1)
      expect(Post.find(1).editable?(2)).to eq false
    end

    it 'returns false if the post at question is not owned by the current user and the post is more than 10 minutes old' do
      new_user = User.create(id: 2, username: 'camlogie', full_name: 'Dan Holmes', password: 'hunter2', email: 'cam@makers.com' )
      post = Post.create(id: 1, message: "I should not be editable", created_at: DateTime.now() - 10.minutes, user_id: 1)
      expect(Post.find(1).editable?(2)).to eq false
    end
      
  end

  describe '.owned_by?(current_user_id)' do
    it 'returns true if the posts user_id is the same as the current users id' do
      Post.create(id: 1, message: 'I am owned by user 1', user_id: 1)
      expect(Post.find(1).owned_by?(1)).to eq true
    end
    it 'returns false if the posts user_id is not the same as the current users id' do
      new_user = User.create(id: 2, username: 'camlogie', full_name: 'Dan Holmes', password: 'hunter2', email: 'cam@makers.com' )
      post = Post.create(id: 1, message: 'I am owned by user 1', user_id: 1)
      expect(Post.find(1).owned_by?(2)).to eq false
    end
  end

  describe '.is_less_than_ten_minutes_old?' do
    it 'Returns false if a message is greater than 10 minutes old' do
      post = Post.create(id: 1, message: "Line 1\nLine 2", created_at: DateTime.now() - 10.minutes, user_id: 1)
      expect(post.is_less_than_ten_minutes_old?).to eq false
    end

    it 'Returns true if a message is less than 10 minutes old' do  
      post = Post.create(id: 1, message: "Line 1\nLine 2", user_id: 1)
      expect(post.is_less_than_ten_minutes_old?).to eq true
    end
  end
end
