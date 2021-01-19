# frozen_string_literal: true

require 'rails_helper'

RSpec.describe '/api/auth', type: :request do
  let(:valid_attributes) { { **attributes_for(:user), password: 'password', password_confirmation: 'password' } }
  let(:response_data)    { JSON.parse(response.body).deep_symbolize_keys }

  describe 'POST /api/auth' do
    before { skip_email_verification }

    it 'authenticates successfully' do
      user = User.create! valid_attributes
      post api_v1_auth_url, params: valid_attributes.slice(:email, :password), as: :json
      expect(response).to have_http_status(:success)
      expect(response_data[:id]).to eq(user.id)
    end

    it 'authenticates successfully when client remembers session' do
      User.create! valid_attributes
      post api_v1_auth_url, params: { **valid_attributes.slice(:email, :password), remember: true }, as: :json
      expect(response).to have_http_status(:success)
    end

    it 'does not authenticates' do
      user = User.create! valid_attributes
      post api_v1_auth_url, params: { email: user.email, password: 'invalid password' }, as: :json
      expect(response).to have_http_status(:unprocessable_entity)
    end
  end

  describe 'GET /api/auth' do
    it 'returns current users data when session is active' do
      user = User.create! valid_attributes
      get api_v1_auth_url, headers: headers_for(user), as: :json
      expect(response).to have_http_status(:ok)
      expect(response_data[:id]).to eq(user.id)
    end

    it 'invalid authentication' do
      get api_v1_auth_url, headers: { 'access-token': 'invalid token' }, as: :json
      expect(response).to have_http_status(:unauthorized)
    end
  end
end
