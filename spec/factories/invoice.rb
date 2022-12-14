FactoryBot.define do
  factory :invoice, class: Invoice do
    status { rand(0..2) }
    association :customer, factory: :customer
    association :merchant, factory: :merchant
  end
end
