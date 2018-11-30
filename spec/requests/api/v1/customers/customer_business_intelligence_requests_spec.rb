require 'rails_helper'

describe "Customer Business Intelligence Endpoints" do

  describe "Customer's Favorite Merchant by Number of Success Transactions" do

    it 'Should return merchant with most successful transactions' do
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

      get "/api/v1/customers/#{c_id}/favorite_merchant"

      returned_merch = JSON.parse(response.body)["data"]["attributes"]

      expect(returned_merch["id"]).to eq(merch_2_id)
      expect(returned_merch["name"]).to eq(merch_2.name)
    end

  end

end
