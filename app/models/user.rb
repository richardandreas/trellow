# frozen_string_literal: true

# Application User
#
# Attributes
#   username:              String
#   email:                 String
#   password:              String
#   password_confirmation: String
#
class User < ApplicationRecord
  auto_strip_attributes :username, squish: true
  auto_strip_attributes :email

  has_one :email_verification, dependent: :destroy
  has_many :projects, dependent: :destroy
  has_many :sprints, through: :projects

  validates :username,
            presence: true,
            uniqueness: true,
            length: { minimum: 6, maximum: 45 },
            format: { with: NO_SPECIAL_CHAR_REGEXP, multiline: true }

  validates :email,
            presence: true,
            uniqueness: true,
            length: { maximum: 90 },
            format: { with: URI::MailTo::EMAIL_REGEXP }

  validates :password,
            presence: { on: create },
            length: { minimum: 6 }, if: :password_digest_changed?

  after_save :send_email_verification

  has_secure_password

  def email_verified?
    email_verified_at.present?
  end

  private

  def send_email_verification
    return unless saved_change_to_email?

    EmailVerification.create(user: self)
    # TODO: Remove line below once the new email is stored in EmailVerification
    update_attribute(:email_verified_at, nil)
  end
end
