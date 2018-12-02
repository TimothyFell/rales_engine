class Merchant < ApplicationRecord
  has_many :items
  has_many :invoices

  def self.best_quantity(quantity)
    Merchant.select('merchants.*, SUM(invoice_items.quantity) AS items_sold')
    .joins(invoices: [:transactions, :invoice_items])
    .where(transactions: {result: 'success'})
    .group('merchants.id')
    .order('items_sold DESC')
    .limit(quantity)
  end

  def self.best_revenue(quantity)
    Merchant.select('merchants.*, SUM(invoice_items.quantity * invoice_items.unit_price) AS revenue')
    .joins(invoices: [:invoice_items, :transactions])
    .where(transactions: {result: 'success'})
    .group('merchants.id')
    .order('revenue DESC')
    .limit(quantity)
  end
end
