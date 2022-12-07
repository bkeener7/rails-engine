require 'rails_helper'

describe 'Item API' do
  it 'sends a list of items' do
    create_list(:item, 10)
    get api_v1_items_path

    expect(response).to be_successful

    items = JSON.parse(response.body, symbolize_names: true)

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

  it 'finds an item by its id' do
    item1 = create(:item)
    get api_v1_item_path(item1)

    expect(response).to be_successful

    item = JSON.parse(response.body, symbolize_names: true)

    expect(item[:data]).to have_key(:id)
    expect(item[:data][:id]).to eq(item1.id.to_s)

    expect(item[:data][:attributes]).to have_key(:description)
    expect(item[:data][:attributes][:description]).to be_a(String)

    expect(item[:data][:attributes]).to have_key(:unit_price)
    expect(item[:data][:attributes][:unit_price]).to be_a(Float)

    expect(item[:data][:attributes]).to have_key(:unit_price)
    expect(item[:data][:attributes][:merchant_id]).to be_a(Integer)
  end

  it 'returns an error if id is invalid' do
    get api_v1_item_path(100000)

    expect(response).to have_http_status(:not_found)
    expect(response.body).to include('Item does not exist')
  end

  it 'can create a new item' do
    merchant1 = create(:merchant)
    item_params = { item: {
      name: Faker::Camera.brand_with_model,
      description: Faker::Hipster.sentence,
      unit_price: Faker::Number.decimal(l_digits: 2),
      merchant_id: merchant1.id
    } }

    post api_v1_items_path(item_params)

    expect(response).to be_successful
    expect(response).to have_http_status(:created)
    expect(Item.last).to have_attributes(item_params[:item])
  end

  it 'can destroy an item' do
    item1 = create(:item)

    expect { delete api_v1_item_path(item1) }.to change(Item, :count).by(-1)
    expect { Item.find(item1.id) }.to raise_exception(ActiveRecord::RecordNotFound)
  end

  it 'can update an item' do
    item1 = create(:item)
    merchant1 = create(:merchant)
    item_params = { item: {
      name: Faker::Camera.brand_with_model,
      description: Faker::Hipster.sentence,
      unit_price: Faker::Number.decimal(l_digits: 2),
      merchant_id: merchant1.id
    } }

    expect(item1).to_not have_attributes(item_params[:item])

    put api_v1_item_path(item1, item_params)

    expect(response).to be_successful
    item1.reload
    expect(item1).to have_attributes(item_params[:item])
  end

  it 'can update partial data' do
    item1 = create(:item)
    merchant1 = create(:merchant)
    item_params = { item: {
      name: Faker::Camera.brand_with_model,
      merchant_id: merchant1.id
    } }

    expect(item1).to_not have_attributes(item_params[:item])

    put api_v1_item_path(item1, item_params)

    expect(response).to be_successful
    item1.reload
    expect(item1).to have_attributes(item_params[:item])
  end

  it 'shows an error when merchant id is invalid' do
    item1 = create(:item)
    item_params = { item: {
      name: Faker::Camera.brand_with_model,
      description: Faker::Hipster.sentence,
      unit_price: Faker::Number.decimal(l_digits: 2),
      merchant_id: 100000
    } }

    put api_v1_item_path(item1, item_params)

    expect(response).to have_http_status(:not_found)
    expect(response.body).to include('Does not exist')
    expect(item1).to_not have_attributes(item_params[:item])
  end
end
