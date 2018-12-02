require 'rails_helper'

describe "Customer Relationship Endpoints" do

  describe 'Invoice Request' do
    it 'should return the items merchant' do
      merch = create(:merchant)
      item = create(:item, merchant_id: merch.id)

      get "/api/v1/items/#{item.id}/merchant"

      response_data = JSON.parse(response.body)["data"]

      merchant = response_data["relationships"]["merchant"]["data"]

      expect(merchant["id"].to_i).to eq(merch.id)
    end

    it 'should return a list of the items invoice_items' do
      merch = create(:merchant)
      customer = create(:customer)
      item = create(:item, merchant_id: merch.id)
      inv = create(:invoice, customer_id: customer.id, merchant_id: merch.id)

      ii_1 = create(:invoice_item, item_id: item.id, invoice_id: inv.id)
      ii_2 = create(:invoice_item, item_id: item.id, invoice_id: inv.id)
      ii_3 = create(:invoice_item, item_id: item.id, invoice_id: inv.id)
      ii_4 = create(:invoice_item, item_id: item.id, invoice_id: inv.id)

      get "/api/v1/items/#{item.id}/invoice_items"

      response_data = JSON.parse(response.body)["data"]

      invoice_items = response_data["relationships"]["invoice_items"]["data"]

      expect(invoice_items.count).to eq(4)
    end
  end

end
