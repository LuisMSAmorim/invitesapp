FactoryBot.define do
  factory :invite do
    title { 'Evento 404' }
    description { 'Este vai ser um evento top das galáxias' }
    date { Date.today }
    inactivated_at { nil }
    company
    user
  end
end
