FactoryBot.define do
  factory :email_verification do
    user { User.last&.id || create(:user).id }
  end
end
