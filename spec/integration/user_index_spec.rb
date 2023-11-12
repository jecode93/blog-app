require 'rails_helper'
require 'capybara/rspec'
require 'capybara/rails'

describe 'testing users/index', type: :feature do
  before(:each) do
    @user1 = User.create(name: 'Mary', photo: 'https://somewhere.com/an_ordinary_photo.jpg', bio: 'Web Developer guy')

    @user2 = User.create(name: 'Bellingham', photo: 'https://somewhere.com/an_ordinary_photo.jpg',
                         bio: 'Bee keeper and bee lover')

    @user3 = User.create(name: 'John', photo: 'https://somewhere.com/an_ordinary_photo.jpg',
                         bio: 'Software developer from Turkey')

    @users = User.all
    visit users_path
  end

  it 'I can see the username of all other users' do
    @users.each do |user|
      expect(page).to have_content(user.name)
    end
  end

  it 'I can see the profile picture for each user' do
    @users.each do |_user|
      expect(page).to have_css('img')
    end
  end

  it 'I can see the number of posts each user has written' do
    @users.each do |user|
      expect(page).to have_content "Number of posts: #{user.posts_counter}"
    end
  end

  it 'When I click on a user, I am redirected to that user\'s show page' do
    click_on @user2.name
    expect(page).to have_current_path user_path(@user2.id)
  end
end
