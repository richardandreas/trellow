FactoryBot.define do
  factory :sprint do
    project_id { Project.last&.id || create(:project).id }
    start_date { Faker::Date.forward(days: 2) }
    due_date   { Faker::Date.between(from: 2.days.from_now, to: 16.days.from_now) }

    trait :with_invalid_start_date do
      start_date { Faker::Date.backward(days: 2) }
    end

    trait :with_invalid_due_date do
      due_date { start_date - 1.day }
    end
  end
end
