require 'rails_helper'

RSpec.describe 'Post', type: :feature do
  before :each do
    @user = User.create(name: 'Harry', photo: 'https://somewhere.com/an_ordinary_photo.jpg',
                        bio: 'Anyone in this world')
    @user.save
    @post = Post.create(author: @user, title: 'Nonsense', text: 'This guy should stop spitting bullshit')
    @post.save
  end

  it 'I can see the user\'s profile picture.' do
    visit user_posts_path(user_id: @user.id)
    expect(page).to have_css("img[src*='#{@user.photo}']")
  end

  it 'I can see the user\'s username.' do
    visit user_posts_path(user_id: @user.id)
    expect(page).to have_content(@user.name)
  end

  it 'I can see the number of posts the user has written' do
    visit user_posts_path(user_id: @user.id)
    expect(page).to have_content(@user.posts_counter)
  end

  it 'I can see a post\'s title' do
    visit user_posts_path(user_id: @user.id)
    expect(page).to have_content(@post.title)
  end

  it 'I can see some of the post\'s body.' do
    visit user_posts_path(user_id: @user.id)
    expect(page).to have_content(@post.text.truncate(40))
  end

  it 'I can see the first comments on a post' do
    comment = Comment.create(user: @user, post: @post, text: 'This is a comment')
    comment.save
    visit user_post_path(user_id: @user.id, id: @post.id)
    expect(page).to have_content(comment.text)
  end

  it 'I can see how many comments a post has' do
    comment = Comment.create(user: @user, post: @post, text: 'This is a comment')
    comment.save
    visit user_post_path(user_id: @user.id, id: @post.id)
    expect(page).to have_content(@post.comments_counter)
  end

  it 'I can see how many likes a post has' do
    like = Like.create(user: @user, post: @post)
    like.save
    visit user_post_path(user_id: @user.id, id: @post.id)
    expect(page).to have_content(@post.likes_counter)
  end

  it 'I can see a section for pagination if there are more posts than fit on the view' do
    visit user_posts_path(user_id: @user.id)
    expect(page).to have_css('.btn-primary')
  end

  it 'When I click on a post, it redirects me to that post\'s show page.' do
    visit user_posts_path(user_id: @user.id)
    click_link 'Read Post'
    expect(page).to have_current_path(user_post_path(user_id: @user.id, id: @post.id))
  end
end
