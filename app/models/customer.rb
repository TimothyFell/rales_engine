class Customer < ApplicationRecord
  has_many :invoices

  def self.customers_fav_merch(id)
    Merchant.select('merchants.*, COUNT(transactions.id) AS merchant_transactions')
    .joins(invoices: [:transactions])
    .where(invoices: {customer_id: id})
    .where(transactions: {result: 'success'})
    .group('merchants.id')
    .order('merchant_transactions desc')
    .limit(1).first
  end
end


# Merchant.select('merchants.*, COUNT(transactions.id) AS merchant_transactions').joins(invoices: [:transactions]).where(invoices: {customer_id: id}).where(transactions: {result: 'success'}).group('merchants.id').order('merchant_transactions desc').limit(1).first
