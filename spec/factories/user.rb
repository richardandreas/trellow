# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    username              { Faker::Name.unique.name.gsub(/[.']/, '') }
    email                 { Faker::Internet.email }
    password              { Faker::Internet.password }
    password_confirmation { password }
    email_verified_at     { Faker::Time.forward(days: 7) }
  end

  trait :with_invalid_username do
    username { 'InvalidUsername!' }
  end

  trait :with_invalid_email do
    email { Faker::Lorem.word }
  end

  trait :with_unequal_passwords do
    password_confirmation { Faker::Internet.password }
  end
end
