# frozen_string_literal: true

require 'rails_helper'

RSpec.describe EmailVerification, type: :model do
  let(:valid_email_verification) { build(:email_verification) }
  let(:new_email)                { 'new.email@trellow.com' }

  describe 'valid email_verification' do
    it { expect(valid_email_verification).to be_valid }
  end

  describe 'presence validations' do
    it { is_expected.to belong_to(:user) }
  end

  describe 'length validations' do
    it { is_expected.to validate_length_of(:new_email).is_at_most(90) }
  end

  describe 'other validations' do
    it 'does not allow new email that is already taken by another user' do
      user = create(:user)
      email_verification = build(:email_verification, new_email: user.email)
      expect(email_verification).to have(1).errors_on(:new_email)
    end
  end

  describe 'confirm' do
    it 'sets email_verified_at attribute in user' do
      new_user = create(:user, :with_unverified_email)
      expect do
        new_user.email_verification.confirm
      end.to change { new_user.email_verified_at }.from(NilClass).to(Time)
    end

    it 'updates users email' do
      expect do
        valid_email_verification.confirm
      end.to change { valid_email_verification.user.email }.to(valid_email_verification.new_email)
    end
  end
end
