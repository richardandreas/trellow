# frozen_string_literal: true

FactoryBot.define do
  factory :project do
    user_id     { User.last&.id || create(:user).id }
    name        { Faker::Lorem.sentence(word_count: 2).gsub('.', '').titleize }
    description { Faker::Lorem.paragraph(sentence_count: 10) }

    trait :with_invalid_name do
      name { 'InvalidProjectName!' }
    end
  end
end
