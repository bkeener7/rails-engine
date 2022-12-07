require 'rails_helper'

describe 'Merchant API' do
  it 'sends a list of merchants' do
    create_list(:merchant, 10)
    get api_v1_merchants_path

    expect(response).to be_successful

    merchants = JSON.parse(response.body, symbolize_names: true)

    expect(merchants).to be_a(Hash)
    expect(merchants[:data].count).to eq(10)

    merchants[:data].each do |merchant|
      expect(merchant).to have_key(:id)
      expect(merchant[:id]).to be_a(String)

      expect(merchant[:attributes]).to have_key(:name)
      expect(merchant[:attributes][:name]).to be_a(String)
    end
  end

  it 'can get one merchant by its id' do
    merchant1 = create(:merchant)
    get api_v1_merchant_path(merchant1)

    expect(response).to be_successful

    merchant = JSON.parse(response.body, symbolize_names: true)

    expect(merchant[:data]).to have_key(:id)
    expect(merchant[:data][:id]).to eq(merchant1.id.to_s)

    expect(merchant[:data][:attributes]).to have_key(:name)
    expect(merchant[:data][:attributes][:name]).to be_a(String)
  end

  it 'returns an error if id is invalid' do
    get api_v1_merchant_path(100000)

    expect(response).to have_http_status(:not_found)
  end
end
