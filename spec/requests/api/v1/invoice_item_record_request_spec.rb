require 'rails_helper'

describe "Invoices Record Endpoints" do

  describe 'Index and Show Requests' do

    it "sends the list of all invoice_items" do
      # test invoice index api
      merch = create(:merchant)
      customer = create(:customer)
      item = create(:item, merchant_id: merch.id)
      inv = create(:invoice, merchant_id: merch.id, customer_id: customer.id)
      i_i_1 = create(:invoice_item, invoice_id: inv.id,item_id: item.id )
      i_i_2 = create(:invoice_item, invoice_id: inv.id,item_id: item.id )
      i_i_2 = create(:invoice_item, invoice_id: inv.id,item_id: item.id )

      get '/api/v1/invoice_items'

      expect(response).to be_successful

      invoice_items = JSON.parse(response.body)["data"]

      expect(invoice_items.count).to eq(3)
    end

    it "sends a single invoice_item" do
      merch = create(:merchant)
      customer = create(:customer)
      item = create(:item, merchant_id: merch.id)
      inv = create(:invoice, merchant_id: merch.id, customer_id: customer.id)
      id = create(:invoice_item, invoice_id: inv.id,item_id: item.id ).id

      get "/api/v1/invoice_items/#{id}"

      expect(response).to be_successful

      invoice_item = JSON.parse(response.body)["data"]

      expect(invoice_item["id"].to_i.to_i).to eq(id)
    end

  end

  describe 'Find Requests' do

    it "can find an invoice_item by their id" do
      merch = create(:merchant)
      customer = create(:customer)
      item = create(:item, merchant_id: merch.id)
      inv = create(:invoice, merchant_id: merch.id, customer_id: customer.id)
      id = create(:invoice_item, invoice_id: inv.id,item_id: item.id ).id

      get "/api/v1/invoice_items/find?id=#{id}"

      expect(response).to be_successful

      invoice_items = JSON.parse(response.body)["data"]

      expect(invoice_items["id"].to_i).to eq(id)
    end

    it "can find an invoice_items by its item_id" do
      merch = create(:merchant)
      customer = create(:customer)
      item = create(:item, merchant_id: merch.id)
      inv = create(:invoice, merchant_id: merch.id, customer_id: customer.id)
      id = create(:invoice_item, invoice_id: inv.id,item_id: item.id ).id

      get "/api/v1/invoice_items/find?item_id=#{item.id}"

      expect(response).to be_successful

      invoice_items = JSON.parse(response.body)["data"]

      expect(invoice_items["attributes"]["item_id"]).to eq(item.id)
    end

    it "can find an invoice_item by its invoice_id" do
      merch = create(:merchant)
      customer = create(:customer)
      item = create(:item, merchant_id: merch.id)
      inv = create(:invoice, merchant_id: merch.id, customer_id: customer.id)
      id = create(:invoice_item, invoice_id: inv.id,item_id: item.id ).id

      get "/api/v1/invoice_items/find?invoice_id=#{inv.id}"

      expect(response).to be_successful

      invoice = JSON.parse(response.body)["data"]

      expect(invoice["attributes"]["invoice_id"]).to eq(inv.id)
    end

    it "can find an invoice_item by its created_at datetime" do
      merch = create(:merchant)
      customer = create(:customer)
      item = create(:item, merchant_id: merch.id)
      inv = create(:invoice, merchant_id: merch.id, customer_id: customer.id)
      ii = create(:invoice_item, created_at: '2012-03-27 14:53:59 UTC', invoice_id: inv.id,item_id: item.id )

      get "/api/v1/invoice_items/find?created_at=#{ii.created_at}"

      expect(response).to be_successful

      json_invoice_item = JSON.parse(response.body)["data"]

      expect(json_invoice_item["id"].to_i).to eq(ii.id)
    end

    it "can find an invoice_items by its updated_at datetime" do
      merch = create(:merchant)
      customer = create(:customer)
      item = create(:item, merchant_id: merch.id)
      inv = create(:invoice, merchant_id: merch.id, customer_id: customer.id)
      ii = create(:invoice_item, updated_at: '2012-03-27 14:53:59 UTC', invoice_id: inv.id,item_id: item.id )

      get "/api/v1/invoice_items/find?updated_at=#{ii.updated_at}"

      expect(response).to be_successful

      json_invoice_item = JSON.parse(response.body)["data"]

      expect(json_invoice_item["id"].to_i).to eq(ii.id)
    end

  end

  describe 'Find_all Requests' do

    it "can find all invoice_items by an id" do
      merch = create(:merchant)
      customer = create(:customer)
      item = create(:item, merchant_id: merch.id)
      inv = create(:invoice, merchant_id: merch.id, customer_id: customer.id)
      ii_1 = create(:invoice_item, invoice_id: inv.id,item_id: item.id )
      ii_2 = create(:invoice_item, invoice_id: inv.id,item_id: item.id )
      ii_3 = create(:invoice_item, invoice_id: inv.id,item_id: item.id )

      get "/api/v1/invoice_items/find_all?id=#{ii_1.id}"

      expect(response).to be_successful

      invoice_item_array = JSON.parse(response.body)["data"]

      expect(invoice_item_array.length).to eq(1)
      expect(invoice_item_array.first["id"].to_i).to eq(ii_1.id)
    end

    it "can find all invoice_items by a item_id" do
      merch = create(:merchant)
      customer = create(:customer)
      item_1 = create(:item, merchant_id: merch.id)
      item_2 = create(:item, merchant_id: merch.id)
      inv = create(:invoice, merchant_id: merch.id, customer_id: customer.id)
      ii_1 = create(:invoice_item, invoice_id: inv.id,item_id: item_1.id )
      ii_2 = create(:invoice_item, invoice_id: inv.id,item_id: item_1.id )
      ii_3 = create(:invoice_item, invoice_id: inv.id,item_id: item_2.id )

      get "/api/v1/invoice_items/find_all?item_id=#{item_1.id}"

      expect(response).to be_successful

      invoice_item_array = JSON.parse(response.body)["data"]

      expect(invoice_item_array.length).to eq(2)
      expect(invoice_item_array.first["attributes"]["id"]).to eq(ii_1.id)
      expect(invoice_item_array.last["attributes"]["id"]).to eq(ii_2.id)
    end

    it "can find all invoice_items by a invoice_id" do
      merch = create(:merchant)
      customer = create(:customer)
      item = create(:item, merchant_id: merch.id)
      inv_1 = create(:invoice, merchant_id: merch.id, customer_id: customer.id)
      inv_2 = create(:invoice, merchant_id: merch.id, customer_id: customer.id)
      ii_1 = create(:invoice_item, invoice_id: inv_1.id,item_id: item.id )
      ii_2 = create(:invoice_item, invoice_id: inv_2.id,item_id: item.id )
      ii_3 = create(:invoice_item, invoice_id: inv_1.id,item_id: item.id )

      get "/api/v1/invoice_items/find_all?invoice_id=#{inv_1.id}"

      expect(response).to be_successful

      invoice_item_array = JSON.parse(response.body)["data"]

      expect(invoice_item_array.length).to eq(2)
      expect(invoice_item_array.first["attributes"]["id"]).to eq(ii_1.id)
      expect(invoice_item_array.last["attributes"]["id"]).to eq(ii_3.id)
    end

    it "can find all invoice_items by a created_at datetime" do
      merch = create(:merchant)
      customer = create(:customer)
      item = create(:item, merchant_id: merch.id)
      inv_1 = create(:invoice, merchant_id: merch.id, customer_id: customer.id)
      inv_2 = create(:invoice, merchant_id: merch.id, customer_id: customer.id)
      ii_1 = create(:invoice_item, created_at: '2012-03-27 14:53:59 UTC', invoice_id: inv_1.id,item_id: item.id )
      ii_2 = create(:invoice_item, created_at: '2012-04-27 12:53:59 UTC', invoice_id: inv_2.id,item_id: item.id )
      ii_3 = create(:invoice_item, created_at: '2012-03-27 14:53:59 UTC', invoice_id: inv_1.id,item_id: item.id )

      get "/api/v1/invoice_items/find_all?created_at=#{ii_1.created_at}"

      expect(response).to be_successful

      json_invoice_array = JSON.parse(response.body)["data"]

      expect(json_invoice_array.length).to eq(2)
      expect(json_invoice_array.first["id"].to_i).to eq(ii_1.id)
      expect(json_invoice_array.last["id"].to_i).to eq(ii_3.id)
    end

    it "can find all invoice_items by an updated_at datetime" do
      merch = create(:merchant)
      customer = create(:customer)
      item = create(:item, merchant_id: merch.id)
      inv_1 = create(:invoice, merchant_id: merch.id, customer_id: customer.id)
      inv_2 = create(:invoice, merchant_id: merch.id, customer_id: customer.id)
      ii_1 = create(:invoice_item, updated_at: '2012-03-27 14:53:59 UTC', invoice_id: inv_1.id,item_id: item.id )
      ii_2 = create(:invoice_item, updated_at: '2012-04-27 12:53:59 UTC', invoice_id: inv_2.id,item_id: item.id )
      ii_3 = create(:invoice_item, updated_at: '2012-03-27 14:53:59 UTC', invoice_id: inv_1.id,item_id: item.id )

      get "/api/v1/invoice_items/find_all?updated_at=#{ii_1.updated_at}"

      expect(response).to be_successful

      json_invoice_array = JSON.parse(response.body)["data"]

      expect(json_invoice_array.length).to eq(2)
      expect(json_invoice_array.first["id"].to_i).to eq(ii_1.id)
      expect(json_invoice_array.last["id"].to_i).to eq(ii_3.id)
    end

  end

  describe 'Random Enpoint' do

    it 'should return a random invoice_item' do
      merch = create(:merchant)
      customer = create(:customer)
      inv = create(:invoice, merchant_id: merch.id, customer_id: customer.id)
      item = create(:item, merchant_id: merch.id)
      ii_1 = create(:invoice_item, invoice_id: inv.id,item_id: item.id )
      ii_2 = create(:invoice_item, invoice_id: inv.id,item_id: item.id )
      ii_3 = create(:invoice_item, invoice_id: inv.id,item_id: item.id )
      ii_4 = create(:invoice_item, invoice_id: inv.id,item_id: item.id )
      ii_5 = create(:invoice_item, invoice_id: inv.id,item_id: item.id )
      ii_6 = create(:invoice_item, invoice_id: inv.id,item_id: item.id )
      ii_7 = create(:invoice_item, invoice_id: inv.id,item_id: item.id )
      ii_8 = create(:invoice_item, invoice_id: inv.id,item_id: item.id )
      ii_9 = create(:invoice_item, invoice_id: inv.id,item_id: item.id )
      ii_10 = create(:invoice_item, invoice_id: inv.id,item_id: item.id )


      invoice_item_ids = InvoiceItem.all.pluck(:id)

      get '/api/v1/invoice_items/random.json'

      rand_invoice_item = JSON.parse(response.body)["data"]

      expect(invoice_item_ids).to include(rand_invoice_item["id"].to_i)
    end

  end

end
