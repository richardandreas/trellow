# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    username { Faker::Name.name.gsub('.', '') }
    email { Faker::Internet.email }
    password { Faker::Internet.password }
  end

  trait :with_invalid_username do
    username { 'InvalidUsername!' }
  end

  trait :with_invalid_email do
    email { Faker::Lorem.word }
  end
end
