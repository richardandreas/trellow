# frozen_string_literal: true

# Email Verification for new users or users who updated their email
#
# Attributes
#   user:      User
#   new_email: String
#
# Methods
#   confirm:   Boolean
#
class EmailVerification < ApplicationRecord
  belongs_to :user

  validates :new_email,
            length: { maximum: 90 },
            format: { with: URI::MailTo::EMAIL_REGEXP, allow_blank: true }

  validate :new_email_is_unique

  after_create :send_email_verification

  private

  def new_email_is_unique
    errors.add(:new_email, :taken) if User.find_by_email(new_email)
  end

  def send_email_verification
    EmailVerificationMailer.send_email_verification_email_for(self).deliver_later
  end
end
