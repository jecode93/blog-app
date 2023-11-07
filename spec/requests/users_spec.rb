require 'rails_helper'

RSpec.describe 'Users', type: :request do
  context 'GET /index' do
    before :each do
      User.create(name: 'Tom')
      get users_path
    end

    it 'renders the right view file' do
      expect(response).to render_template(:index)
    end

    it 'returns http status 200' do
      expect(response.status).to eq(200)
    end

    it 'returns successful response' do
      expect(response).to be_successful
    end
  end

  context 'GET /show' do
    let(:valid_attributes) { { 'name' => 'Tom' } }
    let(:user) { User.create! valid_attributes }
    before :each do
      get user_url(user)
    end

    it 'renders the right view file' do
      expect(response).to render_template(:show)
    end

    it 'returns http status 200' do
      expect(response.status).to eq(200)
    end

    it 'returns successful response' do
      expect(response).to be_successful
    end
  end
end
