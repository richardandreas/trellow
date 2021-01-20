# frozen_string_literal: true

# Application User
#
# Attributes
#   username:              String
#   email:                 String
#   password:              String
#   password_confirmation: String
#
# Methods
#   authenticate           Boolean
#
class User < ApplicationRecord
  scope :all_active, -> { where.not(email_verified_at: nil) }

  auto_strip_attributes :username, squish: true
  auto_strip_attributes :email

  has_one :email_verification, autosave: true, dependent: :destroy
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

  before_save :create_email_verification

  has_secure_password

  private

  def create_email_verification
    return unless email_changed?

    if email_was.nil?
      self.email_verification = EmailVerification.new(user: self)
    else
      self.email_verification = EmailVerification.new(user: self, new_email: email)
      self.email              = email_was
    end
  end
end
