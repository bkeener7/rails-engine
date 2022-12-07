FactoryBot.define do
  factory :transaction, class: Transaction do
    credit_card_number { Faker::Number.number(digits: 16) }
    credit_card_expiration_date { Faker::Date.forward(days: 3000) }
    result { rand(0..1) }
    association :invoice, factory: :invoice
  end
end
