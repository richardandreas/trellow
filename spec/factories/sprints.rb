# frozen_string_literal: true

FactoryBot.define do
  factory :sprint do
    project_id { Project.last&.id || create(:project).id }
    start_date { Faker::Date.forward(days: 7) }
    due_date   { Faker::Date.between(from: 7.days.from_now, to: 14.days.from_now) }

    trait :with_invalid_start_date do
      start_date { Date.yesterday }
    end

    trait :with_invalid_due_date do
      due_date { start_date - 1.day }
    end
  end
end
