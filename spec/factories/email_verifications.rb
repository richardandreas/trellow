# frozen_string_literal: true

FactoryBot.define do
  factory :email_verification do
    user_id   { User.last&.id || create(:user).id }
    new_email { Faker::Internet.email }
  end
end
