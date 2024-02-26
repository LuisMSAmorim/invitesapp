FactoryBot.define do
  factory :user do
    sequence :email do |n|
      "person#{n}@example.com"
    end
    role { 'user' }
    trait :admin do
      role { 'admin' }
    end
  end
end
