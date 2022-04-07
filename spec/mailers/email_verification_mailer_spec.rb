# frozen_string_literal: true

require 'rails_helper'

RSpec.describe EmailVerificationMailer, type: :mailer do
  describe 'email_verification_mail' do
    let(:email_verification) { create(:email_verification) }
    let(:mail)               { described_class.email_verification_mail(email_verification).deliver_now }

    it 'renders the receiver email' do
      expect(mail.to).to eq([email_verification.user.email])
    end

    it 'assigns @confirmation_url' do
      expect(mail.body.encoded).to include("#{root_url}email_verifications/#{email_verification.uuid}")
    end
  end
end
