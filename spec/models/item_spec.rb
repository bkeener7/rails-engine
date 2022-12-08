require 'rails_helper'

RSpec.describe Item, type: :model do
  describe 'relationships' do
    it { should belong_to :merchant }
    it { should have_many :invoice_items }
    it { should have_many(:invoices).through(:invoice_items) }
    it { should have_many(:customers).through(:invoices) }
  end

  describe 'validations' do
    it { should validate_presence_of :name }
    it { should validate_presence_of :description }
    it { should validate_presence_of :unit_price }
    it { should validate_numericality_of(:unit_price).is_greater_than(0) }
    it { should validate_presence_of :merchant_id }
  end

  describe 'class methods' do
    it 'can find all items by partial matches' do
      item1 = create(:item, name: 'Nikon D6400')
      item2 = create(:item, name: 'Nikon D3200')
      item3 = create(:item, name: 'Canon EOS 90D')

      item_params = {
        name: 'KoN'
      }

      expect(Item.find_item_fragment(item_params)).to eq([item1, item2])
    end
  end
end
