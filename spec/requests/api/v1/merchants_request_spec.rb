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

    merchant = JSON.parse(response.body)

    expect(merchant["id"]).to eq(id)
  end

  it "can create a new merchant" do

  end

end
