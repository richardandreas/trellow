# frozen_string_literal: true

# EmailVerification
class EmailVerification < ApplicationRecord
  belongs_to :user

  after_create :send_email_verification

  private

  def send_email_verification
    EmailVerificationMailer.send_email_verification_email_for(self).deliver_later
  end
end
