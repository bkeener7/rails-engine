class Transaction < ApplicationRecord
  belongs_to :invoice
  has_one :merchant, through: :invoice

  validates :credit_card_number, :result, :invoice_id, presence: true
end
