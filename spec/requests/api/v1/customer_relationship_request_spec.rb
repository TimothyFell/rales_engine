require 'rails_helper'

describe "Customer Relationship Endpoints" do

  describe 'Invoice Request' do
    it 'should return a list of the customers invoices' do
      c = create(:customer)
      c_id = c.id

      merch_1_id = create(:merchant).id
      merch_2 = create(:merchant)
      merch_2_id = merch_2.id

      i_1 = create(:invoice, customer_id: c_id, merchant_id: merch_1_id)
      i_2 = create(:invoice, customer_id: c_id, merchant_id: merch_1_id)
      i_3 = create(:invoice, customer_id: c_id, merchant_id: merch_2_id)
      i_4 = create(:invoice, customer_id: c_id, merchant_id: merch_2_id)
      i_5 = create(:invoice, customer_id: c_id, merchant_id: merch_2_id)

      get "/api/v1/customers/#{c_id}/invoices"

      response_data = JSON.parse(response.body)["data"]

      invoices = response_data["relationships"]["invoices"]["data"]

      expect(response).to be_successful
      expect(response_data["id"].to_i).to eq(c_id)
      expect(invoices.count).to eq(5)

    end
  end

  describe 'Transaction Request' do
    xit 'should return a list of the customers transactions' do
      c = create(:customer)
      c_id = c.id

      merch_1_id = create(:merchant).id
      merch_2 = create(:merchant)
      merch_2_id = merch_2.id

      i_1 = create(:invoice, customer_id: c_id, merchant_id: merch_1_id)
      i_2 = create(:invoice, customer_id: c_id, merchant_id: merch_1_id)
      i_3 = create(:invoice, customer_id: c_id, merchant_id: merch_2_id)
      i_4 = create(:invoice, customer_id: c_id, merchant_id: merch_2_id)
      i_5 = create(:invoice, customer_id: c_id, merchant_id: merch_2_id)

      ta_1 = create(:transaction, invoice_id: i_1.id, result: 'success')
      ta_2 = create(:transaction, invoice_id: i_2.id, result: 'success')
      ta_3 = create(:transaction, invoice_id: i_3.id, result: 'success')
      ta_4 = create(:transaction, invoice_id: i_4.id, result: 'success')
      ta_5 = create(:transaction, invoice_id: i_5.id, result: 'success')

      get "/api/v1/customers/#{c_id}/transactions"

      response_data = JSON.parse(response.body)["data"]
      binding.pry

      transactions = response_data["relationships"]["transactions"]["data"]

      expect(response).to be_successful
      expect(response_data["id"].to_i).to eq(c_id)
      expect(transactions.count).to eq(5)
    end
  end

end
