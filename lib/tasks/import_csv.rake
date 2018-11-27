namespace :import do

  task merchants: :environment do
    customers = File.join Rails.root, "/data/customers.csv"
    CSV.foreach(customers, headers:true) do |row|
      Customer.create(row.to_h)
    end
    invoice_items = File.join Rails.root, "/data/invoice_items.csv"
    CSV.foreach(invoice_items, headers:true) do |row|
      InvoiceItem.create(row.to_h)
    end
    invoices = File.join Rails.root, "/data/invoices.csv"
    CSV.foreach(invoices, headers:true) do |row|
      Invoice.create(row.to_h)
    end
    items = File.join Rails.root, "/data/items.csv"
    CSV.foreach(items, headers:true) do |row|
      Item.create(row.to_h)
    end
    merchants = File.join Rails.root, "/data/merchants.csv"
    CSV.foreach(merchants, headers:true) do |row|
      Merchant.create(row.to_h)
    end
    transactions = File.join Rails.root, "/data/transactions.csv"
    CSV.foreach(transactions, headers:true) do |row|
      Transaction.create(row.to_h)
    end
  end

end
