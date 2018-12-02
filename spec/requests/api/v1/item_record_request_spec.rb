require 'rails_helper'

describe "Item Record Endpoints" do

  describe 'Index and Show Requests' do

    it "sends the list of all items" do
      # test item index api
      merch = create(:merchant)
      create_list(:item, 3, merchant_id: merch.id)

      get '/api/v1/items'

      expect(response).to be_successful

      items = JSON.parse(response.body)["data"]

      expect(items.count).to eq(3)
    end

    it "sends a single item" do
      # test item show api
      merch = create(:merchant)
      id = create(:item, merchant_id: merch.id).id

      get "/api/v1/items/#{id}"

      expect(response).to be_successful

      item = JSON.parse(response.body)["data"]

      expect(item["id"].to_i).to eq(id)
    end

  end

  describe 'Find Requests' do

    it "can find a item by its id" do
      merch = create(:merchant)
      id = create(:item, merchant_id: merch.id).id

      get "/api/v1/items/find?id=#{id}"

      expect(response).to be_successful

      item = JSON.parse(response.body)["data"]

      expect(item["id"].to_i).to eq(id)
    end

    it "can find a item by its name" do
      merch = create(:merchant)
      name = create(:item, merchant_id: merch.id).name

      get "/api/v1/items/find?name=#{name}"

      expect(response).to be_successful

      item = JSON.parse(response.body)["data"]

      expect(item["attributes"]["name"]).to eq(name)
    end

    it "can find a item by its description" do
      merch = create(:merchant)
      description = create(:item, merchant_id: merch.id).description

      get "/api/v1/items/find?description=#{description}"

      expect(response).to be_successful

      item = JSON.parse(response.body)["data"]

      expect(item["attributes"]["description"]).to eq(description)
    end

    it "can find a item by its unit_price" do
      merch = create(:merchant)
      unit_price = create(:item, merchant_id: merch.id).unit_price.to_s

      get "/api/v1/items/find?unit_price=#{unit_price}"

      expect(response).to be_successful

      item = JSON.parse(response.body)["data"]

      expect(item["attributes"]["unit_price"]).to eq(unit_price)
    end

    it "can find a item by its created_at datetime" do
      merch = create(:merchant)
      item = create(:item, created_at: '2012-03-27 14:53:59 UTC', merchant_id: merch.id)
      created_at = item.created_at
      id = item.id

      get "/api/v1/items/find?created_at=#{created_at}"

      expect(response).to be_successful

      json_item = JSON.parse(response.body)["data"]

      expect(json_item["id"].to_i).to eq(id)
    end

    it "can find a item by its updated_at datetime" do
      merch = create(:merchant)
      item = create(:item, updated_at: '2012-03-27 14:53:59 UTC', merchant_id: merch.id)
      updated_at = item.updated_at
      id = item.id

      get "/api/v1/items/find?updated_at=#{updated_at}"

      expect(response).to be_successful

      json_item = JSON.parse(response.body)["data"]

      expect(json_item["id"].to_i).to eq(id)
    end

  end

  describe 'Find_all Requests' do

    it "can find all items by an id" do
      merch = create(:merchant)
      id_1 = create(:item, merchant_id: merch.id).id
      id_2 = create(:item, merchant_id: merch.id).id
      id_3 = create(:item, merchant_id: merch.id).id

      get "/api/v1/items/find_all?id=#{id_1}"

      expect(response).to be_successful

      item_array = JSON.parse(response.body)["data"]

      expect(item_array.length).to eq(1)
      expect(item_array.first["id"].to_i).to eq(id_1)
    end

    it "can find all items by a name" do
      merch = create(:merchant)
      name_1 = create(:item, name: 'Bob', merchant_id: merch.id).name
      name_2 = create(:item, name: 'Robert', merchant_id: merch.id).name
      name_3 = create(:item, name: 'Bob', merchant_id: merch.id).name

      get "/api/v1/items/find_all?name=#{name_1}"

      expect(response).to be_successful

      item_array = JSON.parse(response.body)["data"]

      expect(item_array.length).to eq(2)
      expect(item_array.first["attributes"]["name"]).to eq(name_1)
      expect(item_array.last["attributes"]["name"]).to eq(name_1)
    end

    it "can find all items by a description" do
      merch = create(:merchant)
      description_1 = create(:item, description: 'Shade', merchant_id: merch.id).description
      description_2 = create(:item, description: 'Bond', merchant_id: merch.id).description
      description_3 = create(:item, description: 'Shade', merchant_id: merch.id).description

      get "/api/v1/items/find_all?description=#{description_1}"

      expect(response).to be_successful

      item_array = JSON.parse(response.body)["data"]

      expect(item_array.length).to eq(2)
      expect(item_array.first["attributes"]["description"]).to eq(description_1)
      expect(item_array.last["attributes"]["description"]).to eq(description_1)
    end

    it "can find all items by a created_at datetime" do
      merch = create(:merchant)
      item_1 = create(:item, created_at: '2012-03-27 14:53:59 UTC', merchant_id: merch.id)
      item_2 = create(:item, created_at: '2012-04-27 12:53:59 UTC', merchant_id: merch.id)
      item_3 = create(:item, created_at: '2012-03-27 14:53:59 UTC', merchant_id: merch.id)
      created_at = item_1.created_at
      id_1 = item_1.id
      id_2 = item_2.id
      id_3 = item_3.id

      get "/api/v1/items/find_all?created_at=#{created_at}"

      expect(response).to be_successful

      json_item_array = JSON.parse(response.body)["data"]

      expect(json_item_array.length).to eq(2)
      expect(json_item_array.first["id"].to_i).to eq(id_1)
      expect(json_item_array.last["id"].to_i).to eq(id_3)
    end

    it "can find all items by a updated_at datetime" do
      merch = create(:merchant)
      item_1 = create(:item, updated_at: '2012-03-27 14:53:59 UTC', merchant_id: merch.id)
      item_2 = create(:item, updated_at: '2012-04-27 12:53:59 UTC', merchant_id: merch.id)
      item_3 = create(:item, updated_at: '2012-03-27 14:53:59 UTC', merchant_id: merch.id)
      updated_at = item_1.updated_at
      id_1 = item_1.id
      id_2 = item_2.id
      id_3 = item_3.id

      get "/api/v1/items/find_all?updated_at=#{updated_at}"

      expect(response).to be_successful

      json_item_array = JSON.parse(response.body)["data"]

      expect(json_item_array.length).to eq(2)
      expect(json_item_array.first["id"].to_i).to eq(id_1)
      expect(json_item_array.last["id"].to_i).to eq(id_3)
    end

  end

  describe 'Random Enpoint' do

    it 'should return a random record' do
      merch = create(:merchant)
      item_1 = create(:item, merchant_id: merch.id)
      item_2 = create(:item, merchant_id: merch.id)
      item_3 = create(:item, merchant_id: merch.id)
      item_4 = create(:item, merchant_id: merch.id)
      item_5 = create(:item, merchant_id: merch.id)
      item_6 = create(:item, merchant_id: merch.id)
      item_7 = create(:item, merchant_id: merch.id)
      item_8 = create(:item, merchant_id: merch.id)
      item_9 = create(:item, merchant_id: merch.id)
      item_10 = create(:item, merchant_id: merch.id)

      item_ids = Item.all.pluck(:id)

      get '/api/v1/items/random.json'

      rand_item = JSON.parse(response.body)["data"]

      expect(item_ids).to include(rand_item["id"].to_i)
    end

  end

end
