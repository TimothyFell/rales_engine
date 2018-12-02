require 'rails_helper'

describe "Item Business Intelligence Endpoints" do

  describe "Top x items by revenue" do
    it 'should return x items that sold the most by revenue' do
      merch_id = create(:merchant).id
      cust_id = create(:customer).id
      item_id_1 = create(:item, merchant_id: merch_id, unit_price: 1.50).id
      item_id_2 = create(:item, merchant_id: merch_id, unit_price: 2.50).id
      item_id_3 = create(:item, merchant_id: merch_id, unit_price: 3.50).id
      item_id_4 = create(:item, merchant_id: merch_id, unit_price: 4.50).id
      item_id_5 = create(:item, merchant_id: merch_id, unit_price: 5.50).id

      i_1 = create(:invoice, customer_id: cust_id, merchant_id: merch_id, created_at: '2012-03-25 14:53:59 UTC')
      i_2 = create(:invoice, customer_id: cust_id, merchant_id: merch_id, created_at: '2012-03-26 14:53:59 UTC')
      i_3 = create(:invoice, customer_id: cust_id, merchant_id: merch_id, created_at: '2012-03-27 14:53:59 UTC')
      i_4 = create(:invoice, customer_id: cust_id, merchant_id: merch_id, created_at: '2012-03-28 14:53:59 UTC')
      i_5 = create(:invoice, customer_id: cust_id, merchant_id: merch_id, created_at: '2012-03-29 14:53:59 UTC')

      t_1 = create(:transaction, invoice_id: i_1.id, result: 'success')
      t_2 = create(:transaction, invoice_id: i_2.id, result: 'success')
      t_3 = create(:transaction, invoice_id: i_3.id, result: 'success')
      t_4 = create(:transaction, invoice_id: i_4.id, result: 'success')
      t_5 = create(:transaction, invoice_id: i_5.id, result: 'success')

      i_i_1 = create(:invoice_item, invoice_id: i_1.id, item_id: item_id_1, quantity: 1)
      i_i_2 = create(:invoice_item, invoice_id: i_2.id, item_id: item_id_2, quantity: 2)
      i_i_3 = create(:invoice_item, invoice_id: i_3.id, item_id: item_id_3, quantity: 3)
      i_i_4 = create(:invoice_item, invoice_id: i_4.id, item_id: item_id_4, quantity: 4)
      i_i_5 = create(:invoice_item, invoice_id: i_5.id, item_id: item_id_5, quantity: 5)

      get "/api/v1/items/most_revenue?quantity=3"

      best_items = JSON.parse(response.body)["data"]
      first_revenue = best_items[0]["attributes"]["revenue"].to_i
      second_revenue = best_items[1]["attributes"]["revenue"].to_i
      third_revenue = best_items[2]["attributes"]["revenue"].to_i

      expect(best_items.count).to eq(3)
      expect(best_items.first["id"].to_i).to eq(item_id_5)
      expect(best_items.last["id"].to_i).to eq(item_id_3)

      expect(first_revenue).to be > (second_revenue)
      expect(second_revenue).to be > (third_revenue)
    end
  end

  describe "Top x items by quantity sold" do
    it 'should return x items that sold the most by quantity' do
      merch_id = create(:merchant).id
      cust_id = create(:customer).id
      item_id_1 = create(:item, merchant_id: merch_id).id
      item_id_2 = create(:item, merchant_id: merch_id).id
      item_id_3 = create(:item, merchant_id: merch_id).id
      item_id_4 = create(:item, merchant_id: merch_id).id
      item_id_5 = create(:item, merchant_id: merch_id).id

      i_1 = create(:invoice, customer_id: cust_id, merchant_id: merch_id, created_at: '2012-03-25 14:53:59 UTC')
      i_2 = create(:invoice, customer_id: cust_id, merchant_id: merch_id, created_at: '2012-03-26 14:53:59 UTC')
      i_3 = create(:invoice, customer_id: cust_id, merchant_id: merch_id, created_at: '2012-03-27 14:53:59 UTC')
      i_4 = create(:invoice, customer_id: cust_id, merchant_id: merch_id, created_at: '2012-03-28 14:53:59 UTC')
      i_5 = create(:invoice, customer_id: cust_id, merchant_id: merch_id, created_at: '2012-03-29 14:53:59 UTC')

      t_1 = create(:transaction, invoice_id: i_1.id, result: 'success')
      t_2 = create(:transaction, invoice_id: i_2.id, result: 'success')
      t_3 = create(:transaction, invoice_id: i_3.id, result: 'success')
      t_4 = create(:transaction, invoice_id: i_4.id, result: 'success')
      t_5 = create(:transaction, invoice_id: i_5.id, result: 'success')

      i_i_1 = create(:invoice_item, invoice_id: i_1.id, item_id: item_id_1, quantity: 1)
      i_i_2 = create(:invoice_item, invoice_id: i_2.id, item_id: item_id_2, quantity: 2)
      i_i_3 = create(:invoice_item, invoice_id: i_3.id, item_id: item_id_3, quantity: 3)
      i_i_4 = create(:invoice_item, invoice_id: i_4.id, item_id: item_id_4, quantity: 4)
      i_i_5 = create(:invoice_item, invoice_id: i_5.id, item_id: item_id_5, quantity: 5)

      get "/api/v1/items/most_items?quantity=3"

      best_items = JSON.parse(response.body)["data"]


      expect(best_items.count).to eq(3)
      expect(best_items.first["id"].to_i).to eq(item_id_5)
      expect(best_items.last["id"].to_i).to eq(item_id_3)
    end
  end

  describe "Item's Best Day Request" do

    it 'should return ' do
      merch_id = create(:merchant).id
      cust_id = create(:customer).id
      item_id = create(:item, merchant_id: merch_id).id

      i_1 = create(:invoice, customer_id: cust_id, merchant_id: merch_id, created_at: '2012-03-25 14:53:59 UTC')
      i_2 = create(:invoice, customer_id: cust_id, merchant_id: merch_id, created_at: '2012-03-26 14:53:59 UTC')
      i_3 = create(:invoice, customer_id: cust_id, merchant_id: merch_id, created_at: '2012-03-27 14:53:59 UTC')
      i_4 = create(:invoice, customer_id: cust_id, merchant_id: merch_id, created_at: '2012-03-28 14:53:59 UTC')
      i_5 = create(:invoice, customer_id: cust_id, merchant_id: merch_id, created_at: '2012-03-29 14:53:59 UTC')

      i_i_1 = create(:invoice_item, invoice_id: i_1.id, item_id: item_id, quantity: 1)
      i_i_2 = create(:invoice_item, invoice_id: i_2.id, item_id: item_id, quantity: 2)
      i_i_3 = create(:invoice_item, invoice_id: i_3.id, item_id: item_id, quantity: 3)
      i_i_4 = create(:invoice_item, invoice_id: i_4.id, item_id: item_id, quantity: 4)
      i_i_5 = create(:invoice_item, invoice_id: i_5.id, item_id: item_id, quantity: 5)

      get "/api/v1/items/#{item_id}/best_day"

      best_date = JSON.parse(response.body)["data"]["attributes"]["best_day"]
      best_datetime = Time.zone.parse(best_date)

      expect(best_datetime).to eq(i_5["created_at"])
    end

  end

end
