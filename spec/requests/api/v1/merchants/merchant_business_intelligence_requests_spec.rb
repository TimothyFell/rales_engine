require 'rails_helper'

describe "Merchant Business Intelligence Endpoints" do
    describe "Top x merchants by revenue" do
      it 'should return x merchant that sold the most by revenue' do
        merch_id_1 = create(:merchant).id
        merch_id_2 = create(:merchant).id
        merch_id_3 = create(:merchant).id
        merch_id_4 = create(:merchant).id
        merch_id_5 = create(:merchant).id

        cust_id = create(:customer).id

        item_id_1 = create(:item, merchant_id: merch_id_1).id
        item_id_2 = create(:item, merchant_id: merch_id_2).id
        item_id_3 = create(:item, merchant_id: merch_id_3).id
        item_id_4 = create(:item, merchant_id: merch_id_4).id
        item_id_5 = create(:item, merchant_id: merch_id_5).id

        i_1 = create(:invoice, customer_id: cust_id, merchant_id: merch_id_1, created_at: '2012-03-25 14:53:59 UTC')
        i_2 = create(:invoice, customer_id: cust_id, merchant_id: merch_id_2, created_at: '2012-03-26 14:53:59 UTC')
        i_3 = create(:invoice, customer_id: cust_id, merchant_id: merch_id_3, created_at: '2012-03-27 14:53:59 UTC')
        i_4 = create(:invoice, customer_id: cust_id, merchant_id: merch_id_4, created_at: '2012-03-28 14:53:59 UTC')
        i_5 = create(:invoice, customer_id: cust_id, merchant_id: merch_id_5, created_at: '2012-03-29 14:53:59 UTC')

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

        get "/api/v1/merchants/most_revenue?quantity=3"

        best_merchants = JSON.parse(response.body)["data"]
        first_revenue = best_merchants[0]["attributes"]["revenue"]
        second_revenue = best_merchants[1]["attributes"]["revenue"]
        third_revenue = best_merchants[2]["attributes"]["revenue"]

        expect(best_merchants.count).to eq(3)
        expect(best_merchants.first["id"].to_i).to eq(merch_id_5)
        expect(best_merchants.last["id"].to_i).to eq(merch_id_3)

        expect(first_revenue).to be > (second_revenue)
        expect(second_revenue).to be > (third_revenue)
      end
    end

    describe "Top x items by quantity sold" do
      it 'should return x items that sold the most by quantity' do
        merch_id_1 = create(:merchant).id
        merch_id_2 = create(:merchant).id
        merch_id_3 = create(:merchant).id
        merch_id_4 = create(:merchant).id
        merch_id_5 = create(:merchant).id

        cust_id = create(:customer).id

        item_id_1 = create(:item, merchant_id: merch_id_1).id
        item_id_2 = create(:item, merchant_id: merch_id_2).id
        item_id_3 = create(:item, merchant_id: merch_id_3).id
        item_id_4 = create(:item, merchant_id: merch_id_4).id
        item_id_5 = create(:item, merchant_id: merch_id_5).id

        i_1 = create(:invoice, customer_id: cust_id, merchant_id: merch_id_1, created_at: '2012-03-25 14:53:59 UTC')
        i_2 = create(:invoice, customer_id: cust_id, merchant_id: merch_id_2, created_at: '2012-03-26 14:53:59 UTC')
        i_3 = create(:invoice, customer_id: cust_id, merchant_id: merch_id_3, created_at: '2012-03-27 14:53:59 UTC')
        i_4 = create(:invoice, customer_id: cust_id, merchant_id: merch_id_4, created_at: '2012-03-28 14:53:59 UTC')
        i_5 = create(:invoice, customer_id: cust_id, merchant_id: merch_id_5, created_at: '2012-03-29 14:53:59 UTC')

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

        get "/api/v1/merchants/most_items?quantity=3"

        best_merchants = JSON.parse(response.body)["data"]


        expect(best_merchants.count).to eq(3)
        expect(best_merchants.first["id"].to_i).to eq(merch_id_5)
        expect(best_merchants.last["id"].to_i).to eq(merch_id_3)
      end
    end
end
