require 'rails_helper'

describe "Invoices Record Endpoints" do

  describe 'Index and Show Requests' do

    it "sends the list of all invoice_items" do
      # test invoice index api
      merch = create(:merchant)
      customer = create(:customer)
      id_1 = create(:invoice, merchant_id: merch.id, customer_id: customer.id)
      id_2 = create(:invoice, merchant_id: merch.id, customer_id: customer.id)
      id_3 = create(:invoice, merchant_id: merch.id, customer_id: customer.id)

      get '/api/v1/invoices'

      expect(response).to be_successful

      invoices = JSON.parse(response.body)["data"]

      expect(invoices.count).to eq(3)
    end

    it "sends a single invoice_item" do
      merch = create(:merchant)
      customer = create(:customer)
      id = create(:invoice, merchant_id: merch.id, customer_id: customer.id).id

      get "/api/v1/invoices/#{id}"

      expect(response).to be_successful

      invoice = JSON.parse(response.body)["data"]

      expect(invoice["id"].to_i.to_i).to eq(id)
    end

  end

  describe 'Find Requests' do

    it "can find an invoice_item by their id" do
      merch = create(:merchant)
      customer = create(:customer)
      id = create(:invoice, merchant_id: merch.id, customer_id: customer.id).id

      get "/api/v1/invoices/find?id=#{id}"

      expect(response).to be_successful

      invoice = JSON.parse(response.body)["data"]

      expect(invoice["id"].to_i).to eq(id)
    end

    it "can find an invoice_items by its item_id" do
      merch = create(:merchant)
      customer = create(:customer)
      customer_id= create(:invoice, merchant_id: merch.id, customer_id: customer.id).customer_id

      get "/api/v1/invoices/find?customer_id=#{customer_id}"

      expect(response).to be_successful

      invoice = JSON.parse(response.body)["data"]

      expect(invoice["attributes"]["customer_id"]).to eq(customer_id)
    end

    it "can find an invoice_item by its invoice_id" do
      merch = create(:merchant)
      customer = create(:customer)
      merchant_id = create(:invoice, merchant_id: merch.id, customer_id: customer.id).merchant_id

      get "/api/v1/invoices/find?merchant_id=#{merchant_id}"

      expect(response).to be_successful

      invoice = JSON.parse(response.body)["data"]

      expect(invoice["attributes"]["merchant_id"]).to eq(merchant_id)
    end

    it "can find an invoice_item by its created_at datetime" do
      merch = create(:merchant)
      customer = create(:customer)
      invoice = create(:invoice, created_at: '2012-03-27 14:53:59 UTC', merchant_id: merch.id, customer_id: customer.id)
      created_at = invoice.created_at
      id = invoice.id

      get "/api/v1/invoices/find?created_at=#{created_at}"

      expect(response).to be_successful

      json_invoice = JSON.parse(response.body)["data"]

      expect(json_invoice["id"].to_i).to eq(id)
    end

    it "can find an invoice_items by its updated_at datetime" do
      merch = create(:merchant)
      customer = create(:customer)
      invoice = create(:invoice, updated_at: '2012-03-27 14:53:59 UTC', merchant_id: merch.id, customer_id: customer.id)
      updated_at = invoice.updated_at
      id = invoice.id

      get "/api/v1/invoices/find?updated_at=#{updated_at}"

      expect(response).to be_successful

      json_invoice = JSON.parse(response.body)["data"]

      expect(json_invoice["id"].to_i).to eq(id)
    end

  end

  describe 'Find_all Requests' do

    it "can find all invoice_items by an id" do
      merch = create(:merchant)
      customer = create(:customer)
      id_1 = create(:invoice, merchant_id: merch.id, customer_id: customer.id).id
      id_2 = create(:invoice, merchant_id: merch.id, customer_id: customer.id).id
      id_3 = create(:invoice, merchant_id: merch.id, customer_id: customer.id).id

      get "/api/v1/invoices/find_all?id=#{id_1}"

      expect(response).to be_successful

      invoice_array = JSON.parse(response.body)["data"]

      expect(invoice_array.length).to eq(1)
      expect(invoice_array.first["id"].to_i).to eq(id_1)
    end

    it "can find all invoice_items by a item_id" do
      merch = create(:merchant)
      customer = create(:customer)
      customer_id_1 = create(:invoice, merchant_id: merch.id, customer_id: customer.id).customer_id
      customer_id_2 = create(:invoice, merchant_id: merch.id, customer_id: customer.id).customer_id
      customer_id_3 = create(:invoice, merchant_id: merch.id, customer_id: customer.id).customer_id

      get "/api/v1/invoices/find_all?customer_id=#{customer.id}"

      expect(response).to be_successful

      invoice_array = JSON.parse(response.body)["data"]

      expect(invoice_array.length).to eq(3)
      expect(invoice_array.first["attributes"]["customer_id"]).to eq(customer_id_1)
      expect(invoice_array[1]["attributes"]["customer_id"]).to eq(customer_id_2)
      expect(invoice_array.last["attributes"]["customer_id"]).to eq(customer_id_3)
    end

    it "can find all invoice_items by a invoice_id" do
      merch = create(:merchant)
      customer = create(:customer)
      merchant_id_1 = create(:invoice, merchant_id: merch.id, customer_id: customer.id).merchant_id
      merchant_id_2 = create(:invoice, merchant_id: merch.id, customer_id: customer.id).merchant_id
      merchant_id_3 = create(:invoice, merchant_id: merch.id, customer_id: customer.id).merchant_id

      get "/api/v1/invoices/find_all?merchant_id=#{merch.id}"

      expect(response).to be_successful

      invoice_array = JSON.parse(response.body)["data"]

      expect(invoice_array.length).to eq(3)
      expect(invoice_array.first["attributes"]["merchant_id"]).to eq(merchant_id_1)
      expect(invoice_array[1]["attributes"]["merchant_id"]).to eq(merchant_id_2)
      expect(invoice_array.last["attributes"]["merchant_id"]).to eq(merchant_id_3)
    end

    it "can find all invoice_items by a created_at datetime" do
      merch = create(:merchant)
      customer = create(:customer)
      invoice_1 = create(:invoice, created_at: '2012-03-27 14:53:59 UTC', merchant_id: merch.id, customer_id: customer.id)
      invoice_2 = create(:invoice, created_at: '2012-04-27 12:53:59 UTC', merchant_id: merch.id, customer_id: customer.id)
      invoice_3 = create(:invoice, created_at: '2012-03-27 14:53:59 UTC', merchant_id: merch.id, customer_id: customer.id)
      created_at = invoice_1.created_at
      id_1 = invoice_1.id
      id_2 = invoice_2.id
      id_3 = invoice_3.id

      get "/api/v1/invoices/find_all?created_at=#{created_at}"

      expect(response).to be_successful

      json_invoice_array = JSON.parse(response.body)["data"]

      expect(json_invoice_array.length).to eq(2)
      expect(json_invoice_array.first["id"].to_i).to eq(id_1)
      expect(json_invoice_array.last["id"].to_i).to eq(id_3)
    end

    it "can find all invoice_items by an updated_at datetime" do
      merch = create(:merchant)
      customer = create(:customer)
      invoice_1 = create(:invoice, updated_at: '2012-03-27 14:53:59 UTC', merchant_id: merch.id, customer_id: customer.id)
      invoice_2 = create(:invoice, updated_at: '2012-04-27 12:53:59 UTC', merchant_id: merch.id, customer_id: customer.id)
      invoice_3 = create(:invoice, updated_at: '2012-03-27 14:53:59 UTC', merchant_id: merch.id, customer_id: customer.id)
      updated_at = invoice_1.updated_at
      id_1 = invoice_1.id
      id_2 = invoice_2.id
      id_3 = invoice_3.id

      get "/api/v1/invoices/find_all?updated_at=#{updated_at}"

      expect(response).to be_successful

      json_invoice_array = JSON.parse(response.body)["data"]

      expect(json_invoice_array.length).to eq(2)
      expect(json_invoice_array.first["id"].to_i).to eq(id_1)
      expect(json_invoice_array.last["id"].to_i).to eq(id_3)
    end

  end

  describe 'Random Enpoint' do

    it 'should return a random invoice_item' do
      merch = create(:merchant)
      customer = create(:customer)
      invoice_1 = create(:invoice, merchant_id: merch.id, customer_id: customer.id)
      invoice_2 = create(:invoice, merchant_id: merch.id, customer_id: customer.id)
      invoice_3 = create(:invoice, merchant_id: merch.id, customer_id: customer.id)
      invoice_4 = create(:invoice, merchant_id: merch.id, customer_id: customer.id)
      invoice_5 = create(:invoice, merchant_id: merch.id, customer_id: customer.id)
      invoice_6 = create(:invoice, merchant_id: merch.id, customer_id: customer.id)
      invoice_7 = create(:invoice, merchant_id: merch.id, customer_id: customer.id)
      invoice_8 = create(:invoice, merchant_id: merch.id, customer_id: customer.id)
      invoice_9 = create(:invoice, merchant_id: merch.id, customer_id: customer.id)
      invoice_10 = create(:invoice, merchant_id: merch.id, customer_id: customer.id)

      invoice_ids = Invoice.all.pluck(:id)

      get '/api/v1/invoices/random.json'

      rand_invoice = JSON.parse(response.body)["data"]

      expect(invoice_ids).to include(rand_invoice["id"].to_i)
    end

  end

end
