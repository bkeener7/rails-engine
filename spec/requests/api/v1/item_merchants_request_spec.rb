require 'rails_helper'

describe 'Item Merchants API' do
  it 'can find a items merchant' do
    merchant1 = create(:merchant)
    item1 = create(:item, merchant_id: merchant1.id)

    get item_merchants_path(item1)

    expect(response).to be_successful

    item_merchant = JSON.parse(response.body, symbolize_names: true)

    expect(item_merchant[:data][:id]).to eq(merchant1.id.to_s)
    expect(item_merchant[:data][:attributes][:name]).to eq(merchant1.name)
  end

  it 'returns an error if item does not exist' do
    get item_merchants_path(100000)

    expect(response).to have_http_status(:not_found)
    expect(response.body).to include('Item does not exist')
  end
end
