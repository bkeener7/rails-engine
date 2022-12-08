require 'rails_helper'

RSpec.describe Merchant, type: :model do
  describe 'relationships' do
    it { should have_many :items }
    it { should have_many(:invoice_items).through(:items) }
    it { should have_many(:invoices).through(:invoice_items) }
    it { should have_many(:customers).through(:invoices) }
    it { should have_many(:transactions).through(:invoices) }
  end

  describe 'validations' do
    it { should validate_presence_of :name }
  end

  describe 'class methods' do
    it 'can find names by partial matches' do
      merchant1 = create(:merchant, name: 'Walter White')
      merchant2 = create(:merchant, name: 'Hank Schrader')
      merchant3 = create(:merchant, name: 'Gus Fring')

      merchant_params = {
        name: 'iTe'
      }

      expect(Merchant.find_merchant_fragment(merchant_params)).to eq(merchant1)
    end
  end
end
