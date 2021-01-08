# frozen_string_literal: true

require 'rails_helper'

RSpec.describe '/api/auth', type: :request do
  let(:valid_attributes) { { **attributes_for(:user), password: 'password', password_confirmation: 'password' } }

  describe 'POST /api/auth' do
    it 'authenticates successfully' do
      User.create! valid_attributes
      post api_v1_auth_url, params: valid_attributes.slice(:email, :password), as: :json
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
      access_token = JwtService.encode({ user_id: user.id, expiration: 1.minutes.from_now })
      get api_v1_auth_url, headers: { 'access-token': access_token }, as: :json
      expect(response).to have_http_status(:ok)
    end

    it 'invalid authentication' do
      get api_v1_auth_url, headers: { 'access-token': 'invalid token' }, as: :json
      expect(response).to have_http_status(:unauthorized)
    end
  end
end
