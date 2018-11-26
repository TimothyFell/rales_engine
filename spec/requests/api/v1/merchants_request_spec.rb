require 'rails_helper'

describe "Merchants API" do

  it "sends the list of merchants" do
    create_list(:merchant, 3)

    get '/api/v1/merchants'

    expect(response).to be_successful
  end

end
