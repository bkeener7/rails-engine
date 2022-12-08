require 'rails_helper'

describe 'Items Search API' do
  it 'can find a partial match' do
    item1 = create(:item, name: 'Nikon D6400')
    item2 = create(:item, name: 'Nikon D3200')
    item3 = create(:item, name: 'Canon EOS 90D')

    get '/api/v1/items/find_all?name=KoN'

    expect(response).to be_successful

    item_result = JSON.parse(response.body, symbolize_names: true)

    expect(item_result[:data].length).to eq(2)

    expect(item_result[:data][0][:attributes][:name]).to include(item1.name)
    expect(item_result[:data][1][:attributes][:name]).to include(item2.name)
  end

  it 'will return an error if there are no matches' do
    item1 = create(:item, name: 'Nikon D6400')
    item2 = create(:item, name: 'Nikon D3200')
    item3 = create(:item, name: 'Canon EOS 90D')

    get '/api/v1/items/find_all?name=QQQ'

    expect(response).to have_http_status(:not_found)
  end
end
