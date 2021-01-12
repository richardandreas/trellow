# frozen_string_literal: true

# Project
#
# Attributes
#   user:         User
#   name:         String
#   descripition: String
#
class Project < ApplicationRecord
  auto_strip_attributes :name, squish: true
  auto_strip_attributes :description

  belongs_to :user

  has_many :sprints, dependent: :destroy

  validates :name,
            presence: true,
            uniqueness: { scope: :user_id },
            length: { minimum: 3, maximum: 45 },
            format: { with: NO_SPECIAL_CHAR_REGEXP, multiline: true }

  validates :description,
            length: { maximum: 2000 }
end
