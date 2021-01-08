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
  validates :username,
            presence: true,
            uniqueness: true,
            length: { minimum: 6, maximum: 45 },
            format: { with: /^[a-zA-Z 0-9]*$/, multiline: true }

  validates :email,
            presence: true,
            uniqueness: true,
            length: { maximum: 90 },
            format: { with: URI::MailTo::EMAIL_REGEXP }

  validates :password,
            presence: true,
            length: { minimum: 6 }

  auto_strip_attributes :username, squish: true

  has_secure_password
end
