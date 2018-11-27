require 'rails_helper'

describe "Customers API" do

  it "sends the list of customers" do
    # test customer index api
    create_list(:customer, 3)

    get '/api/v1/customers'

    expect(response).to be_successful

    customers = JSON.parse(response.body)

    expect(customers.count).to eq(3)
  end

  it "sends a single customer by id" do
    # test customer show api
    id = create(:customer).id

    get "/api/v1/customers/#{id}"

    expect(response).to be_successful

    customer = JSON.parse(response.body)

    expect(customer["id"]).to eq(id)
  end

  it "can find a customer by their id" do
    id = create(:customer).id

    get "/api/v1/customers/find?id=#{id}"

    expect(response).to be_successful

    customer = JSON.parse(response.body)

    expect(customer["id"]).to eq(id)
  end

  it "can find a customer by their first name" do
    first_name = create(:customer).first_name

    get "/api/v1/customers/find?first_name=#{first_name}"

    expect(response).to be_successful

    customer = JSON.parse(response.body)

    expect(customer["first_name"]).to eq(first_name)
  end

  it "can find a customer by their last name" do
    last_name = create(:customer).last_name

    get "/api/v1/customers/find?last_name=#{last_name}"

    expect(response).to be_successful

    customer = JSON.parse(response.body)

    expect(customer["last_name"]).to eq(last_name)
  end

  it "can find a customer by their created_at datetime" do
    customer = create(:customer, created_at: '2012-03-27 14:53:59 UTC')
    created_at = customer.created_at
    id = customer.id

    get "/api/v1/customers/find?created_at=#{created_at}"

    expect(response).to be_successful

    json_customer = JSON.parse(response.body)

    expect(json_customer["id"]).to eq(id)
  end

  it "can find a customer by their updated_at datetime" do
    customer = create(:customer, updated_at: '2012-03-27 14:53:59 UTC')
    updated_at = customer.updated_at
    id = customer.id

    get "/api/v1/customers/find?updated_at=#{updated_at}"

    expect(response).to be_successful

    json_customer = JSON.parse(response.body)

    expect(json_customer["id"]).to eq(id)
  end

end
