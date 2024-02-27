FactoryBot.define do
  factory :user do
    sequence :email do |n|
      "person#{n}@example.com"
    end
    role { 'user' }
    password { '123Test@!#' }
    trait :admin do
      role { 'admin' }
    end
  end
end
