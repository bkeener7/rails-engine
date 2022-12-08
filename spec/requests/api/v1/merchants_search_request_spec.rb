require 'rails_helper'

describe 'Merchants Search API' do
  it 'can find a partial match' do
    merchant1 = create(:merchant, name: 'Walter White')
    merchant2 = create(:merchant, name: 'Hank Schrader')
    merchant3 = create(:merchant, name: 'Gus Fring')

    get '/api/v1/merchants/find?name=iTe'

    expect(response).to be_successful

    merchant_result = JSON.parse(response.body, symbolize_names: true)

    expect(merchant_result[:data][:attributes][:name]).to eq(merchant1.name)
  end

  it 'will return an error if there are no matches' do
    merchant1 = create(:merchant, name: 'Walter White')
    merchant2 = create(:merchant, name: 'Hank Schrader')
    merchant3 = create(:merchant, name: 'Gus Fring')

    get '/api/v1/merchants/find?name=QQQ'

    expect(response).to have_http_status(:not_found)
    expect(response.body).to include('Does not exist')
  end
end
