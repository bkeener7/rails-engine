FactoryBot.define do
  factory :invoice_item, class: InvoiceItem do
    quantity { Faker::Number.between(from: 1, to: 100) }
    unit_price { Faker::Number.between(from: 1, to: 100000) }
    association :invoice, factory: :invoice
    association :item, factory: :item
  end
end
