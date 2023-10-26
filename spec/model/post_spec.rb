require 'rails_helper'

RSpec.describe Post, type: :model do
  before :all do
    @user = User.create(name: 'Someone', photo: '', bio: 'Yet another human.')
    @user.save
    @post = Post.create(author: @user, title: 'Hello world', text: 'Hello world body')
  end

  describe 'validation' do
    it 'should validate the presence of the title' do
      @post.title = nil
      expect(@post).to_not be_valid
    end

    it 'should validate the length of the title to be less than 250 characters' do
      @post.title = 'a' * 251
      expect(@post).to_not be_valid
    end

    it 'should validate the numericality of the comments_counter' do
      @post.comments_counter = 'hello'
      expect(@post).to_not be_valid
    end

    it 'comments_counter should be a positive number' do
      @post.comments_counter = -5
      expect(@post).to_not be_valid
    end

    it 'should validate the numericality of the likes_counter' do
      @post.likes_counter = 'hello'
      expect(@post).to_not be_valid
    end

    it 'likes_counter should be a positive number' do
      @post.likes_counter = -5
      expect(@post).to_not be_valid
    end
  end

  describe 'Associations' do
    it 'should have many comments' do
      expect(@post.comments).to eq([])
    end

    it 'should have many likes' do
      expect(@post.likes).to eq([])
    end

    it 'should belong to an author' do
      expect(@post.author).to eq(@user)
    end
  end

  describe 'recent comments' do
    it 'should return the 5 most recent comments for a given post' do
      6.times do |i|
        Comment.create(user: @user, post: @post, text: "Comment #{i}")
      end
      expect(@post.five_recent_comments).to eq(@post.comments.order(created_at: :desc).limit(5))
    end
  end
end
