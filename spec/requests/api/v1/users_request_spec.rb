# frozen_string_literal: true

require 'rails_helper'

RSpec.describe '/api/v1/users', type: :request do
  let(:valid_attributes)            { attributes_for(:user) }
  let(:invalid_attributes)          { attributes_for(:user, :with_invalid_username) }
  let(:unverified_email_attributes) { attributes_for(:user, :with_unverified_email) }

  before { skip_token_auth }

  describe 'GET /index' do
    it 'renders a successful response' do
      User.create! valid_attributes
      get api_v1_users_url, as: :json
      expect(response).to have_http_status(:ok)
    end
  end

  describe 'GET /show' do
    it 'renders a successful response' do
      user = User.create! valid_attributes
      get api_v1_user_url(user), as: :json
      expect(response).to have_http_status(:ok)
    end
  end

  describe 'POST /create' do
    context 'with valid parameters' do
      it 'creates a new User' do
        expect do
          post api_v1_users_url, params: valid_attributes, as: :json
        end.to change(User, :count).by(1)
      end
    end

    context 'with invalid parameters' do
      it 'does not create a new User' do
        expect do
          post api_v1_users_url, params: invalid_attributes, as: :json
        end.to change(User, :count).by(0)
      end
    end

    context 'pending email confirmation' do
      it 'creates a EmailVerification' do
        expect do
          post api_v1_users_url, params: unverified_email_attributes, as: :json
        end.to change(EmailVerification, :count).by(1)
      end
    end
  end

  describe 'PATCH /update' do
    context 'with valid parameters' do
      let(:new_attributes) { attributes_for(:user) }

      it 'updates the requested user' do
        user = User.create! valid_attributes
        patch api_v1_user_url(user), params: new_attributes, as: :json
        user.reload
        expect(user.username).to eq(new_attributes[:username])
        expect(user.email).not_to eq(new_attributes[:email])
        expect(user.authenticate(new_attributes[:password])).to be_truthy
      end

      it 'creates a EmailVerification when email changed' do
        user = User.create! valid_attributes
        expect do
          patch api_v1_user_url(user), params: new_attributes, as: :json
        end.to change(EmailVerification, :count).by(1)
      end
    end

    context 'with invalid parameters' do
      it 'renders a successful response (i.e. to display the "edit" template)' do
        user = User.create! valid_attributes
        patch api_v1_user_url(user), params: invalid_attributes, as: :json
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe 'DELETE /destroy' do
    it 'destroys the requested user' do
      user = User.create! valid_attributes
      expect do
        delete api_v1_user_url(user), as: :json
      end.to change(User, :count).by(-1)
    end
  end
end
