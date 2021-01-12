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

  has_secure_password
end
