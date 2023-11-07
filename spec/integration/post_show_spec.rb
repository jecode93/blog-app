require 'rails_helper'

describe 'Testing Post/show', type: :feature do
  before(:each) do
    @user1 = User.create(name: 'Mary', photo: 'https://somewhere.com/an_ordinary_photo.jpg', bio: 'Web Developer guy')
    @user2 = User.create(name: 'John', photo: 'www.unsplash.com', bio: 'Bee keeper and bee lover')
    @first_post = Post.create(author: @user1, title: 'Hello World', text: 'This is my first post')

    @first_comment = Comment.create(user: @user1, post: @first_post, text: 'First comment for the post')
    @second_comment = Comment.create(user: @user1, post: @first_post, text: 'Second comment for the post')
    @third_comment = Comment.create(user: @user1, post: @first_post, text: 'Third comment for the post')

    @first_like = Like.create(post: @first_post, user: @user1)
    @second_like = Like.create(post: @first_post, user: @user1)
    @third_like = Like.create(post: @first_post, user: @user1)

    visit user_posts_path(@user1, @first_post)
  end

  it 'I can see the post\'s title' do
    expect(page).to have_content(@first_post.title)
  end

  it 'I can see who wrote the post' do
    expect(page).to have_content(@user1.name)
  end

  it 'I can see how many comments it has' do
    expect(page).to have_content(@first_post.comments_counter)
  end

  it 'I can see how many likes it has' do
    expect(page).to have_content(@first_post.likes_counter)
  end

  it 'I can see the post body' do
    expect(page).to have_content(@first_post.text)
  end

  it 'I can see the username of each commentor' do
    expect(page).to have_content(@first_comment.user.name)
    expect(page).to have_content(@second_comment.user.name)
    expect(page).to have_content(@third_comment.user.name)
  end

  it 'I can see the comment each commentor left' do
    expect(page).to have_content(@first_comment.text)
    expect(page).to have_content(@second_comment.text)
    expect(page).to have_content(@third_comment.text)
  end
end
