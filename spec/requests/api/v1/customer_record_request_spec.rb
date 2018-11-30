require 'rails_helper'

describe "Customer Record Endpoints" do

  describe 'Index and Show Requests' do

    it "sends the list of all customers" do
      # test customer index api
      create_list(:customer, 3)

      get '/api/v1/customers'

      expect(response).to be_successful

      customers = JSON.parse(response.body)["data"]

      expect(customers.count).to eq(3)
    end

    it "sends a single customer" do
      # test customer show api
      id = create(:customer).id

      get "/api/v1/customers/#{id}"

      expect(response).to be_successful

      customer = JSON.parse(response.body)["data"]

      expect(customer["id"].to_i).to eq(id)
    end

  end

  describe 'Find Requests' do

    it "can find a customer by their id" do
      id = create(:customer).id

      get "/api/v1/customers/find?id=#{id}"

      expect(response).to be_successful

      customer = JSON.parse(response.body)["data"]

      expect(customer["id"].to_i).to eq(id)
    end

    it "can find a customer by their first name" do
      first_name = create(:customer).first_name

      get "/api/v1/customers/find?first_name=#{first_name}"

      expect(response).to be_successful

      customer = JSON.parse(response.body)["data"]

      expect(customer["attributes"]["first_name"]).to eq(first_name)
    end

    it "can find a customer by their last name" do
      last_name = create(:customer).last_name

      get "/api/v1/customers/find?last_name=#{last_name}"

      expect(response).to be_successful

      customer = JSON.parse(response.body)["data"]

      expect(customer["attributes"]["last_name"]).to eq(last_name)
    end

    it "can find a customer by their created_at datetime" do
      customer = create(:customer, created_at: '2012-03-27 14:53:59 UTC')
      created_at = customer.created_at
      id = customer.id

      get "/api/v1/customers/find?created_at=#{created_at}"

      expect(response).to be_successful

      json_customer = JSON.parse(response.body)["data"]

      expect(json_customer["id"].to_i).to eq(id)
    end

    it "can find a customer by their updated_at datetime" do
      customer = create(:customer, updated_at: '2012-03-27 14:53:59 UTC')
      updated_at = customer.updated_at
      id = customer.id

      get "/api/v1/customers/find?updated_at=#{updated_at}"

      expect(response).to be_successful

      json_customer = JSON.parse(response.body)["data"]

      expect(json_customer["id"].to_i).to eq(id)
    end

  end

  describe 'Find_all Requests' do

    it "can find all customers by an id" do
      id_1 = create(:customer).id
      id_2 = create(:customer).id
      id_3 = create(:customer).id

      get "/api/v1/customers/find_all?id=#{id_1}"

      expect(response).to be_successful

      customer_array = JSON.parse(response.body)["data"]

      expect(customer_array.length).to eq(1)
      expect(customer_array.first["id"].to_i).to eq(id_1)
    end

    it "can find all customers by a first name" do
      first_name_1 = create(:customer, first_name: 'Bob').first_name
      first_name_2 = create(:customer, first_name: 'Robert').first_name
      first_name_3 = create(:customer, first_name: 'Bob').first_name

      get "/api/v1/customers/find_all?first_name=#{first_name_1}"

      expect(response).to be_successful

      customer_array = JSON.parse(response.body)["data"]

      expect(customer_array.length).to eq(2)
      expect(customer_array.first["attributes"]["first_name"]).to eq(first_name_1)
      expect(customer_array.last["attributes"]["first_name"]).to eq(first_name_1)
    end

    it "can find all customers by a last name" do
      last_name_1 = create(:customer, last_name: 'Shade').last_name
      last_name_2 = create(:customer, last_name: 'Bond').last_name
      last_name_3 = create(:customer, last_name: 'Shade').last_name

      get "/api/v1/customers/find_all?last_name=#{last_name_1}"

      expect(response).to be_successful

      customer_array = JSON.parse(response.body)["data"]

      expect(customer_array.length).to eq(2)
      expect(customer_array.first["attributes"]["last_name"]).to eq(last_name_1)
      expect(customer_array.last["attributes"]["last_name"]).to eq(last_name_1)
    end

    it "can find all customers by a created_at datetime" do
      customer_1 = create(:customer, created_at: '2012-03-27 14:53:59 UTC')
      customer_2 = create(:customer, created_at: '2012-04-27 12:53:59 UTC')
      customer_3 = create(:customer, created_at: '2012-03-27 14:53:59 UTC')
      created_at = customer_1.created_at
      id_1 = customer_1.id
      id_2 = customer_2.id
      id_3 = customer_3.id

      get "/api/v1/customers/find_all?created_at=#{created_at}"

      expect(response).to be_successful

      json_customer_array = JSON.parse(response.body)["data"]

      expect(json_customer_array.length).to eq(2)
      expect(json_customer_array.first["id"].to_i).to eq(id_1)
      expect(json_customer_array.last["id"].to_i).to eq(id_3)
    end

    it "can find all customers by a updated_at datetime" do
      customer_1 = create(:customer, updated_at: '2012-03-27 14:53:59 UTC')
      customer_2 = create(:customer, updated_at: '2012-04-27 12:53:59 UTC')
      customer_3 = create(:customer, updated_at: '2012-03-27 14:53:59 UTC')
      updated_at = customer_1.updated_at
      id_1 = customer_1.id
      id_2 = customer_2.id
      id_3 = customer_3.id

      get "/api/v1/customers/find_all?updated_at=#{updated_at}"

      expect(response).to be_successful

      json_customer_array = JSON.parse(response.body)["data"]

      expect(json_customer_array.length).to eq(2)
      expect(json_customer_array.first["id"].to_i).to eq(id_1)
      expect(json_customer_array.last["id"].to_i).to eq(id_3)
    end

  end

  describe 'Random Enpoint' do

    it 'should return a random record' do
      customer_1 = create(:customer)
      customer_2 = create(:customer)
      customer_3 = create(:customer)
      customer_4 = create(:customer)
      customer_5 = create(:customer)
      customer_6 = create(:customer)
      customer_7 = create(:customer)
      customer_8 = create(:customer)
      customer_9 = create(:customer)
      customer_10 = create(:customer)

      customer_ids = Customer.all.pluck(:id)

      get '/api/v1/customers/random.json'

      rand_cust = JSON.parse(response.body)["data"]

      expect(customer_ids).to include(rand_cust["id"].to_i)
    end

  end

end
