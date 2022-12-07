FactoryBot.define do
  factory :item, class: Item do
    name { Faker::Cosmere.metal }
    description { Faker::Cosmere.shard }
    unit_price { Faker::Number.between(from: 1, to: 100000) }
    association :merchant, factory: :merchant
  end
end
