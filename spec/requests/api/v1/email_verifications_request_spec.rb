# frozen_string_literal: true

require 'rails_helper'

RSpec.describe '/api/v1/email_verifications', type: :request do
  let(:valid_user)            { create(:user) }
  let(:unverified_email_user) { create(:user, :with_unverified_email) }
  let(:response_data)         { JSON.parse(response.body).deep_symbolize_keys }
  let(:new_email)             { 'new.email@trellow.com' }

  describe 'GET /api/v1/email_verifications' do
    context 'with valid parameters' do
      it 'renders a successful response' do
        email_verification = unverified_email_user.email_verification
        get api_v1_email_verification_url(email_verification), as: :json
        expect(response).to have_http_status(:ok)
      end

      it 'sets email_verified_at attribute in user' do
        email_verification = unverified_email_user.email_verification
        expect do
          get api_v1_email_verification_url(email_verification), as: :json
        end.to change { unverified_email_user.reload.email_verified_at }.from(NilClass).to(Time)
      end

      it 'updates users email' do
        user = valid_user
        user.update!(email: new_email)
        email_verification = user.email_verification
        expect do
          get api_v1_email_verification_url(email_verification), as: :json
        end.to change { user.reload.email }.from(user.email).to(new_email)
      end
    end

    context 'with taken email' do
      it 'renders error' do
        user = valid_user
        user.update!(email: new_email)
        create(:user, email: new_email)
        get api_v1_email_verification_url(user.email_verification), as: :json
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end
end
