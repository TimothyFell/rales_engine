require 'rails_helper'

describe "Merchants Record Endpoints" do

  describe 'Index and Show Requests' do

    it "sends the list of all merchants" do
      # test merchant index api
      create_list(:merchant, 3)

      get '/api/v1/merchants'

      expect(response).to be_successful

      merchants = JSON.parse(response.body)["data"]

      expect(merchants.count).to eq(3)
    end

    it "sends a single merchant" do
      # test merchant show api
      id = create(:merchant).id

      get "/api/v1/merchants/#{id}"

      expect(response).to be_successful

      merchant = JSON.parse(response.body)["data"]

      expect(merchant["id"].to_i.to_i).to eq(id)
    end

  end

  describe 'Find Requests' do

    it "can find a merchant by their id" do
      id = create(:merchant).id

      get "/api/v1/merchants/find?id=#{id}"

      expect(response).to be_successful

      merchant = JSON.parse(response.body)["data"]

      expect(merchant["id"].to_i).to eq(id)
    end

    it "can find a merchant by their name" do
      name = create(:merchant).name

      get "/api/v1/merchants/find?name=#{name}"

      expect(response).to be_successful

      merchant = JSON.parse(response.body)["data"]

      expect(merchant["attributes"]["name"]).to eq(name)
    end

    it "can find a merchant by their created_at datetime" do
      merchant = create(:merchant, created_at: '2012-03-27 14:53:59 UTC')
      created_at = merchant.created_at
      id = merchant.id

      get "/api/v1/merchants/find?created_at=#{created_at}"

      expect(response).to be_successful

      json_merchant = JSON.parse(response.body)["data"]

      expect(json_merchant["id"].to_i).to eq(id)
    end

    it "can find a merchant by their updated_at datetime" do
      merchant = create(:merchant, updated_at: '2012-03-27 14:53:59 UTC')
      updated_at = merchant.updated_at
      id = merchant.id

      get "/api/v1/merchants/find?updated_at=#{updated_at}"

      expect(response).to be_successful

      json_merchant = JSON.parse(response.body)["data"]

      expect(json_merchant["id"].to_i).to eq(id)
    end

  end

  describe 'Find_all Requests' do

    it "can find all merchants by an id" do
      id_1 = create(:merchant).id
      id_2 = create(:merchant).id
      id_3 = create(:merchant).id

      get "/api/v1/merchants/find_all?id=#{id_1}"

      expect(response).to be_successful

      merchant_array = JSON.parse(response.body)["data"]

      expect(merchant_array.length).to eq(1)
      expect(merchant_array.first["id"].to_i).to eq(id_1)
    end

    it "can find all merchants by a name" do
      name_1 = create(:merchant, name: "Shady Bobs").name
      name_2 = create(:merchant, name: "Shady Bobs").name
      name_3 = create(:merchant, name: "Shady Bobs").name

      get "/api/v1/merchants/find_all?name=#{name_1}"

      expect(response).to be_successful

      merchant_array = JSON.parse(response.body)["data"]

      expect(merchant_array.length).to eq(3)
      expect(merchant_array.first["attributes"]["name"]).to eq(name_1)
      expect(merchant_array[1]["attributes"]["name"]).to eq(name_1)
      expect(merchant_array.last["attributes"]["name"]).to eq(name_1)
    end

    it "can find all merchants by a created_at datetime" do
      merchant_1 = create(:merchant, created_at: '2012-03-27 14:53:59 UTC')
      merchant_2 = create(:merchant, created_at: '2012-04-27 12:53:59 UTC')
      merchant_3 = create(:merchant, created_at: '2012-03-27 14:53:59 UTC')
      created_at = merchant_1.created_at
      id_1 = merchant_1.id
      id_2 = merchant_2.id
      id_3 = merchant_3.id

      get "/api/v1/merchants/find_all?created_at=#{created_at}"

      expect(response).to be_successful

      json_merchant_array = JSON.parse(response.body)["data"]

      expect(json_merchant_array.length).to eq(2)
      expect(json_merchant_array.first["id"].to_i).to eq(id_1)
      expect(json_merchant_array.last["id"].to_i).to eq(id_3)
    end

    it "can find all merchants by an updated_at datetime" do
      merchant_1 = create(:merchant, updated_at: '2012-03-27 14:53:59 UTC')
      merchant_2 = create(:merchant, updated_at: '2012-04-27 12:53:59 UTC')
      merchant_3 = create(:merchant, updated_at: '2012-03-27 14:53:59 UTC')
      updated_at = merchant_1.updated_at
      id_1 = merchant_1.id
      id_2 = merchant_2.id
      id_3 = merchant_3.id

      get "/api/v1/merchants/find_all?updated_at=#{updated_at}"

      expect(response).to be_successful

      json_merchant_array = JSON.parse(response.body)["data"]

      expect(json_merchant_array.length).to eq(2)
      expect(json_merchant_array.first["id"].to_i).to eq(id_1)
      expect(json_merchant_array.last["id"].to_i).to eq(id_3)
    end

  end

  describe 'Random Enpoint' do

    it 'should return a random record' do
      merch_1 = create(:merchant)
      merch_2 = create(:merchant)
      merch_3 = create(:merchant)
      merch_4 = create(:merchant)
      merch_5 = create(:merchant)
      merch_6 = create(:merchant)
      merch_7 = create(:merchant)
      merch_8 = create(:merchant)
      merch_9 = create(:merchant)
      merch_10 = create(:merchant)

      merch_ids = Merchant.all.pluck(:id)

      get '/api/v1/merchants/random.json'

      rand_merch = JSON.parse(response.body)["data"]

      expect(merch_ids).to include(rand_merch["id"].to_i)
    end

  end

end
