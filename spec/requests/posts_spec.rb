require 'rails_helper'

RSpec.describe 'Posts', type: :request do
  context 'GET /index' do
    before :each do
      get '/users/6/posts'
    end

    it 'returns http status 200' do
      expect(response.status).to eq(200)
    end

    it 'returns successful response' do
      expect(response).to be_successful
    end

    it 'renders the right view file' do
      expect(response).to render_template(:index)
    end
  end

  context 'GET /show' do
    let(:user) { User.create(name: 'Tom') }
    let(:valid_attributes) { { 'author' => user, 'title' => 'Title' } }
    let(:post) { Post.create! valid_attributes }

    before :each do
      get '/users/6/posts/8'
    end

    it 'renders the right view file' do
      expect(response).to render_template(:show)
    end

    it 'returns successful response' do
      expect(response).to be_successful
    end

    it 'returns http status 200' do
      expect(response.status).to eq(200)
    end
  end
end
