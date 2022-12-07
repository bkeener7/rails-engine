class Transaction < ApplicationRecord
  belongs_to :invoice
  has_one :merchant, through: :invoice

  validates :credit_card_number, :credit_card_expiration_date, :result, :invoice_id, presence: true
end
