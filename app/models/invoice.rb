class Invoice < ApplicationRecord
  belongs_to :customer
  has_many :transactions
  has_many :invoice_items
  has_many :items, through: :invoice_items
  has_many :merchants, through: :items
  validates :status, :customer_id, :merchant_id, presence: true

  enum status: { in_progress: 0, completed: 1, cancelled: 2 }
end
