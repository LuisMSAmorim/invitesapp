FactoryBot.define do
  factory :company do
    sequence :name do |n|
      "Company #{n}"
    end
    ceo { 'John Doe' }
  end
end
