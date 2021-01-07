FactoryBot.define do
  factory :user do
    username { Faker::Name.first_name + Faker::Name.last_name }
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
