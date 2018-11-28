require 'rails_helper'

describe "Merchants API" do

  describe 'Index and Show Requests' do

    it "sends the list of merchants" do
      # test merchant index api
      create_list(:merchant, 3)

      get '/api/v1/merchants'

      expect(response).to be_successful

      merchants = JSON.parse(response.body)

      expect(merchants.count).to eq(3)
    end

    it "sends a single merchant by id" do
      # test merchant show api
      id = create(:merchant).id

      get "/api/v1/merchants/#{id}"

      expect(response).to be_successful

      merchant = JSON.parse(response.body)

      expect(merchant["id"]).to eq(id)
    end

  end

  describe 'Find Requests' do

    it "can find a merchant by their id" do
      id = create(:merchant).id

      get "/api/v1/merchants/find?id=#{id}"

      expect(response).to be_successful

      merchant = JSON.parse(response.body)

      expect(merchant["id"]).to eq(id)
    end

    it "can find a merchant by their name" do
      name = create(:merchant).name

      get "/api/v1/merchants/find?name=#{name}"

      expect(response).to be_successful

      merchant = JSON.parse(response.body)

      expect(merchant["name"]).to eq(name)
    end

    it "can find a merchant by their created_at datetime" do
      merchant = create(:merchant, created_at: '2012-03-27 14:53:59 UTC')
      created_at = merchant.created_at
      id = merchant.id

      get "/api/v1/merchants/find?created_at=#{created_at}"

      expect(response).to be_successful

      json_merchant = JSON.parse(response.body)

      expect(json_merchant["id"]).to eq(id)
    end

    it "can find a merchant by their updated_at datetime" do
      merchant = create(:merchant, updated_at: '2012-03-27 14:53:59 UTC')
      updated_at = merchant.updated_at
      id = merchant.id

      get "/api/v1/merchants/find?updated_at=#{updated_at}"

      expect(response).to be_successful

      json_merchant = JSON.parse(response.body)

      expect(json_merchant["id"]).to eq(id)
    end

  end

  describe 'Find_all Requests' do

    it "can find any merchants with an id" do
      id_1 = create(:merchant).id
      id_2 = create(:merchant).id
      id_3 = create(:merchant).id

      get "/api/v1/merchants/find_all?id=#{id_1}"

      expect(response).to be_successful

      merchant_array = JSON.parse(response.body)

      expect(merchant_array.length).to eq(1)
      expect(merchant_array.first["id"]).to eq(id_1)
    end

    it "can find all merchants with a name" do
      name_1 = create(:merchant, name: "Shady Bobs").name
      name_2 = create(:merchant, name: "Shady Bobs").name
      name_3 = create(:merchant, name: "Shady Bobs").name

      get "/api/v1/merchants/find_all?name=#{name_1}"

      expect(response).to be_successful

      merchant_array = JSON.parse(response.body)

      expect(merchant_array.length).to eq(3)
      expect(merchant_array.first["name"]).to eq(name_1)
      expect(merchant_array[1]["name"]).to eq(name_1)
      expect(merchant_array.last["name"]).to eq(name_1)
    end

    it "can find a merchant by their created_at datetime" do
      merchant_1 = create(:merchant, created_at: '2012-03-27 14:53:59 UTC')
      merchant_2 = create(:merchant, created_at: '2012-04-27 12:53:59 UTC')
      merchant_3 = create(:merchant, created_at: '2012-03-27 14:53:59 UTC')
      created_at = merchant_1.created_at
      id_1 = merchant_1.id
      id_2 = merchant_2.id
      id_3 = merchant_3.id

      get "/api/v1/merchants/find_all?created_at=#{created_at}"

      expect(response).to be_successful

      json_merchant_array = JSON.parse(response.body)

      expect(json_merchant_array.length).to eq(2)
      expect(json_merchant_array.first["id"]).to eq(id_1)
      expect(json_merchant_array.last["id"]).to eq(id_3)
    end

    it "can find a merchant by their updated_at datetime" do
      merchant_1 = create(:merchant, updated_at: '2012-03-27 14:53:59 UTC')
      merchant_2 = create(:merchant, updated_at: '2012-04-27 12:53:59 UTC')
      merchant_3 = create(:merchant, updated_at: '2012-03-27 14:53:59 UTC')
      updated_at = merchant_1.updated_at
      id_1 = merchant_1.id
      id_2 = merchant_2.id
      id_3 = merchant_3.id

      get "/api/v1/merchants/find_all?updated_at=#{updated_at}"

      expect(response).to be_successful

      json_merchant_array = JSON.parse(response.body)

      expect(json_merchant_array.length).to eq(2)
      expect(json_merchant_array.first["id"]).to eq(id_1)
      expect(json_merchant_array.last["id"]).to eq(id_3)
    end

  end

end
