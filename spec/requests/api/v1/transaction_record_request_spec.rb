require 'rails_helper'

describe "Transactions Record Endpoints" do

  describe 'Index and Show Requests' do

    it "sends the list of all Transactions" do
      # test invoice index api
      merch = create(:merchant)
      customer = create(:customer)
      inv = create(:invoice, merchant_id: merch.id, customer_id: customer.id)
      t_1 = create(:transaction, invoice_id: inv.id)
      t_2 = create(:transaction, invoice_id: inv.id)
      t_3 = create(:transaction, invoice_id: inv.id)

      get '/api/v1/transactions'

      expect(response).to be_successful

      transaction = JSON.parse(response.body)["data"]

      expect(transaction.count).to eq(3)
    end

    it "sends a single transaction" do
      merch = create(:merchant)
      customer = create(:customer)
      inv = create(:invoice, merchant_id: merch.id, customer_id: customer.id)
      t_1 = create(:transaction, invoice_id: inv.id)

      get "/api/v1/transactions/#{t_1.id}"

      expect(response).to be_successful

      transaction = JSON.parse(response.body)["data"]

      expect(transaction["id"].to_i).to eq(t_1.id)
    end

  end

  describe 'Find Requests' do

    it "can find a transcation by its id" do
      merch = create(:merchant)
      customer = create(:customer)
      inv = create(:invoice, merchant_id: merch.id, customer_id: customer.id)
      t_1 = create(:transaction, invoice_id: inv.id)

      get "/api/v1/transactions/find?id=#{t_1.id}"

      expect(response).to be_successful

      transaction = JSON.parse(response.body)["data"]

      expect(transaction["id"].to_i).to eq(t_1.id)
    end

    it "can find a transcation by its invoice_id" do
      merch = create(:merchant)
      customer = create(:customer)
      inv = create(:invoice, merchant_id: merch.id, customer_id: customer.id)
      t_1 = create(:transaction, invoice_id: inv.id)

      get "/api/v1/transactions/find?invoice_id=#{t_1.invoice_id}"

      expect(response).to be_successful

      transaction = JSON.parse(response.body)["data"]

      expect(transaction["attributes"]["id"]).to eq(t_1.id)
    end

    it "returns the first transcation with a credit_card_number" do
      merch = create(:merchant)
      customer = create(:customer)
      inv = create(:invoice, merchant_id: merch.id, customer_id: customer.id)
      t_1 = create(:transaction, invoice_id: inv.id, credit_card_number: '4844518708741275')

      get "/api/v1/transactions/find?credit_card_number=#{t_1.credit_card_number}"

      expect(response).to be_successful

      transaction = JSON.parse(response.body)["data"]

      expect(transaction["attributes"]["id"]).to eq(t_1.id)
    end

    it "returns the first transaction with a result" do
      merch = create(:merchant)
      customer = create(:customer)
      inv = create(:invoice, merchant_id: merch.id, customer_id: customer.id)
      t_1 = create(:transaction, invoice_id: inv.id, result: 'success')

      get "/api/v1/transactions/find?result=#{t_1.result}"

      expect(response).to be_successful

      transaction = JSON.parse(response.body)["data"]

      expect(transaction["attributes"]["id"]).to eq(t_1.id)
    end

    it "can find a transcation by its created_at datetime" do
      merch = create(:merchant)
      customer = create(:customer)
      inv = create(:invoice, merchant_id: merch.id, customer_id: customer.id)
      t_1 = create(:transaction, invoice_id: inv.id, created_at: '2012-03-27 14:53:59 UTC')

      get "/api/v1/transactions/find?created_at=#{t_1.created_at}"

      expect(response).to be_successful

      transaction = JSON.parse(response.body)["data"]

      expect(transaction["id"].to_i).to eq(t_1.id)
    end

    it "can find a transcation by their updated_at datetime" do
      merch = create(:merchant)
      customer = create(:customer)
      inv = create(:invoice, merchant_id: merch.id, customer_id: customer.id)
      t_1 = create(:transaction, invoice_id: inv.id, updated_at: '2012-03-27 14:53:59 UTC')

      get "/api/v1/transactions/find?updated_at=#{t_1.updated_at}"

      expect(response).to be_successful

      transaction = JSON.parse(response.body)["data"]

      expect(transaction["id"].to_i).to eq(t_1.id)
    end

  end

  describe 'Find_all Requests' do

    it "can find all transactions by an id" do
      merch = create(:merchant)
      customer = create(:customer)
      inv = create(:invoice, merchant_id: merch.id, customer_id: customer.id)
      t_1 = create(:transaction, invoice_id: inv.id)
      t_2 = create(:transaction, invoice_id: inv.id)
      t_3 = create(:transaction, invoice_id: inv.id)

      get "/api/v1/transactions/find_all?id=#{t_1.id}"

      expect(response).to be_successful

      transaction_array = JSON.parse(response.body)["data"]

      expect(transaction_array.length).to eq(1)
      expect(transaction_array.first["id"].to_i).to eq(t_1.id)
    end

    it "can find all transactions by a invoice_id" do
      merch = create(:merchant)
      customer = create(:customer)
      inv_1 = create(:invoice, merchant_id: merch.id, customer_id: customer.id)
      inv_2 = create(:invoice, merchant_id: merch.id, customer_id: customer.id)
      t_1 = create(:transaction, invoice_id: inv_1.id)
      t_2 = create(:transaction, invoice_id: inv_2.id)
      t_3 = create(:transaction, invoice_id: inv_1.id)

      get "/api/v1/transactions/find_all?invoice_id=#{t_1.invoice_id}"

      expect(response).to be_successful

      transaction_array = JSON.parse(response.body)["data"]

      expect(transaction_array.length).to eq(2)
      expect(transaction_array.first["attributes"]["id"]).to eq(t_1.id)
      expect(transaction_array.last["attributes"]["id"]).to eq(t_3.id)
    end

    it "can find all transactions by a credit_card_number" do
      merch = create(:merchant)
      customer = create(:customer)
      inv_1 = create(:invoice, merchant_id: merch.id, customer_id: customer.id)
      inv_2 = create(:invoice, merchant_id: merch.id, customer_id: customer.id)
      t_1 = create(:transaction, invoice_id: inv_1.id, credit_card_number: '4844518708741275')
      t_2 = create(:transaction, invoice_id: inv_2.id, credit_card_number: '4844518708740000')
      t_3 = create(:transaction, invoice_id: inv_1.id, credit_card_number: '4844518708741275')

      get "/api/v1/transactions/find_all?credit_card_number=#{t_1.credit_card_number}"

      expect(response).to be_successful

      transaction_array = JSON.parse(response.body)["data"]

      expect(transaction_array.length).to eq(2)
      expect(transaction_array.first["attributes"]["id"]).to eq(t_1.id)
      expect(transaction_array.last["attributes"]["id"]).to eq(t_3.id)
    end

    it "can find all transactions by a result" do
      merch = create(:merchant)
      customer = create(:customer)
      inv_1 = create(:invoice, merchant_id: merch.id, customer_id: customer.id)
      inv_2 = create(:invoice, merchant_id: merch.id, customer_id: customer.id)
      t_1 = create(:transaction, invoice_id: inv_1.id, result: 'success')
      t_2 = create(:transaction, invoice_id: inv_2.id, result: 'FIALURE!')
      t_3 = create(:transaction, invoice_id: inv_1.id, result: 'success')

      get "/api/v1/transactions/find_all?result=#{t_1.result}"

      expect(response).to be_successful

      transaction_array = JSON.parse(response.body)["data"]

      expect(transaction_array.length).to eq(2)
      expect(transaction_array.first["attributes"]["id"]).to eq(t_1.id)
      expect(transaction_array.last["attributes"]["id"]).to eq(t_3.id)
    end

    it "can find all invoices by a created_at datetime" do
      merch = create(:merchant)
      customer = create(:customer)
      inv_1 = create(:invoice, merchant_id: merch.id, customer_id: customer.id)
      inv_2 = create(:invoice, merchant_id: merch.id, customer_id: customer.id)
      t_1 = create(:transaction, invoice_id: inv_1.id, created_at: '2012-03-27 14:53:59 UTC')
      t_2 = create(:transaction, invoice_id: inv_2.id, created_at: '2012-04-27 12:53:59 UTC')
      t_3 = create(:transaction, invoice_id: inv_1.id, created_at: '2012-03-27 14:53:59 UTC')

      get "/api/v1/transactions/find_all?created_at=#{t_1.created_at}"

      expect(response).to be_successful

      json_transaction_array = JSON.parse(response.body)["data"]

      expect(json_transaction_array.length).to eq(2)
      expect(json_transaction_array.first["id"].to_i).to eq(t_1.id)
      expect(json_transaction_array.last["id"].to_i).to eq(t_3.id)
    end

    it "can find all invoices by an updated_at datetime" do
      merch = create(:merchant)
      customer = create(:customer)
      inv_1 = create(:invoice, merchant_id: merch.id, customer_id: customer.id)
      inv_2 = create(:invoice, merchant_id: merch.id, customer_id: customer.id)
      t_1 = create(:transaction, invoice_id: inv_1.id, updated_at: '2012-03-27 14:53:59 UTC')
      t_2 = create(:transaction, invoice_id: inv_2.id, updated_at: '2012-04-27 12:53:59 UTC')
      t_3 = create(:transaction, invoice_id: inv_1.id, updated_at: '2012-03-27 14:53:59 UTC')

      get "/api/v1/transactions/find_all?updated_at=#{t_1.updated_at}"

      expect(response).to be_successful

      json_transaction_array = JSON.parse(response.body)["data"]

      expect(json_transaction_array.length).to eq(2)
      expect(json_transaction_array.first["id"].to_i).to eq(t_1.id)
      expect(json_transaction_array.last["id"].to_i).to eq(t_3.id)
    end

  end

  describe 'Random Enpoint' do

    it 'should return a random record' do
      merch = create(:merchant)
      customer = create(:customer)
      inv_1 = create(:invoice, merchant_id: merch.id, customer_id: customer.id)
      inv_2 = create(:invoice, merchant_id: merch.id, customer_id: customer.id)
      t_1 = create(:transaction, invoice_id: inv_1.id)
      t_2 = create(:transaction, invoice_id: inv_2.id)
      t_3 = create(:transaction, invoice_id: inv_1.id)
      t_4 = create(:transaction, invoice_id: inv_1.id)
      t_5 = create(:transaction, invoice_id: inv_2.id)
      t_6 = create(:transaction, invoice_id: inv_1.id)
      t_7 = create(:transaction, invoice_id: inv_1.id)
      t_8 = create(:transaction, invoice_id: inv_2.id)
      t_9 = create(:transaction, invoice_id: inv_1.id)
      t_10 = create(:transaction, invoice_id: inv_1.id)

      transactions_ids = Transaction.all.pluck(:id)

      get '/api/v1/transactions/random.json'

      rand_transaction = JSON.parse(response.body)["data"]

      expect(transactions_ids).to include(rand_transaction["id"].to_i)
    end

  end

end
