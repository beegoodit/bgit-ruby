FactoryBot.define do
  factory :bgit_frontend_auth_user, class: Bgit::FrontendAuth::User do
    sequence(:email) { |n| "user#{n}@example.com" }
    password { "password" }
    password_confirmation { "password" }

    trait :authenticable do
      active { true }
      confirmed { true }
      approved { true }
    end
  end
end
