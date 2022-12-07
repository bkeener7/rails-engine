require 'rails_helper'

describe 'Merchant Items API' do
  it 'can get all items by a merchant by merchant id' do
    merchant1 = create(:merchant)
    create_list(:item, 10, merchant_id: merchant1.id)
    get merchant_items_path(merchant1)

    items = JSON.parse(response.body, symbolize_names: true)

    expect(response).to be_successful

    expect(items).to be_a(Hash)
    expect(items[:data].count).to eq(10)

    items[:data].each do |item|
      expect(item).to have_key(:id)
      expect(item[:id]).to be_a(String)

      expect(item[:attributes]).to have_key(:description)
      expect(item[:attributes][:description]).to be_a(String)

      expect(item[:attributes]).to have_key(:unit_price)
      expect(item[:attributes][:unit_price]).to be_a(Float)

      expect(item[:attributes]).to have_key(:unit_price)
      expect(item[:attributes][:merchant_id]).to be_a(Integer)
    end
  end

  it 'returns an error if merchant id is invalid' do
    get merchant_items_path(100000)

    expect(response).to have_http_status(:not_found)
    expect(response.body).to include('Merchant does not exist')
  end
end
