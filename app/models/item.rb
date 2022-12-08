class Item < ApplicationRecord
  belongs_to :merchant
  has_many :invoice_items
  has_many :invoices, through: :invoice_items
  has_many :customers, through: :invoices

  validates :name, :description, :unit_price, :merchant_id, presence: true
  validates :unit_price, numericality: { greater_than: 0 }

  def self.find_item_fragment(params)
    where('name ILIKE ?', "%#{params[:name]}%")
  end
end
