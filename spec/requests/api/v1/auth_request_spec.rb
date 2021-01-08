# frozen_string_literal: true

require 'rails_helper'

RSpec.describe '/api/auth', type: :request do
  let(:valid_attributes)   { attributes_for(:user) }
  let(:invalid_attributes) { attributes_for(:user, :with_invalid_password) }

  describe 'POST /api/auth' do
    it 'returns http success' do
      user = User.create! valid_attributes
      post api_v1_auth_url, params: user.attributes.slice(:username, :password), as: :json
      expect(response).to have_http_status(:success)
    end
  end
end
