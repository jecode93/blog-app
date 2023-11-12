require 'rails_helper'
require 'capybara/rspec'
require 'capybara/rails'

RSpec.describe 'User View', type: :feature do
  before :each do
    @user = User.create(name: 'Harry', photo: 'https://somewhere.com/an_ordinary_photo.jpg',
                        bio: 'Anyone in this world')
    @user.save
  end

  it 'I can see the user\'s profile picture' do
    visit user_path(@user)
    expect(page).to have_css("img[src*='https://somewhere.com/an_ordinary_photo.jpg']")
  end

  it 'I can see the user\'s username' do
    visit user_path(@user)
    expect(page).to have_content(@user.name)
  end

  it 'I can see the number of posts the user has written' do
    visit user_path(@user)
    expect(page).to have_content(@user.posts_counter)
  end

  it 'I can see the user\'s bio' do
    visit user_path(@user)
    expect(page).to have_content(@user.bio)
  end

  it 'I can see the user\'s first 3 posts' do
    posts = [
      { title: 'trail',
        text: 'answer bent visitor raw stock elephant roof supper numeral bend previous donkey stand wild there' },
      { title: 'sweater',
        text: 'end me low officer enjoy cool phrase could shut cattle military chair parent fruit sunlight with' },
      { title: 'outer',
        text: 'teach soon origin calm crew writing bee sheep brave create saved remember must unless any society' }
    ]

    posts.each do |post_attrs|
      Post.create(author: @user, **post_attrs).save
    end
    visit user_path(@user)
    posts.first(3).each do |post|
      expect(page).to have_content(post[:title])
    end
  end

  it 'I can see a button that lets me view all of a user\'s posts' do
    visit user_path(@user)
    expect(page).to have_css('.btn-primary')
  end

  it 'When I click a user\'s post, it redirects me to that post\'s show page' do
    post = Post.create(author: @user, title: 'Nonsense', text: 'This guy should stop spitting bullshit')
    post.save
    visit user_path(@user)
    click_link 'Read Post'
    expect(page).to have_current_path(user_post_path(user_id: @user.id, id: post.id))
  end

  it 'When I click to see all posts, it redirects me to the user\'s post\'s index page' do
    visit user_path(@user)
    click_link 'See all post'
    expect(page).to have_current_path(user_posts_path(@user))
  end
end
