require 'rails_helper'

describe "Merchants API" do

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
