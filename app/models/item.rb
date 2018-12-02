class Item < ApplicationRecord
  has_many :invoice_items
  has_many :invoices, through: :invoice_items
  belongs_to :merchant

  def self.best_quantity(quantity)
    Item.select('items.*, SUM(invoice_items.quantity) AS number_sold')
    .joins(:invoice_items,invoices: [:transactions])
    .where(transactions: {result: 'success'})
    .group('items.id')
    .order('number_sold DESC')
    .limit(quantity)
  end

  # Item.select('items.*, SUM(invoice_items.quantity) AS num_sold').joins(:invoice_items,invoices: [:transactions]).where(transactions: {result: 'success'}).group('items.id').order('num_sold DESC').limit(3)

  def self.best_revenue(quantity)
    Item.select('items.*, SUM(invoice_items.quantity * invoice_items.unit_price) AS revenue')
    .joins(:invoice_items,invoices: [:transactions])
    .where(transactions: {result: 'success'})
    .group('items.id')
    .order('revenue DESC')
    .limit(quantity)
  end

  # Item.select('items.*, SUM(invoice_items.quantity) AS num_sold').joins(:invoice_items,invoices: [:transactions]).where(transactions: {result: 'success'}).group('items.id').order('num_sold DESC').limit(3)

  def self.best_day(id)
    Invoice.select("invoices.created_at, sum(invoice_items.quantity) AS units")
    .joins(:invoice_items)
    .where("invoice_items.item_id = #{id}")
    .group("invoices.id")
    .order("units desc, invoices.created_at desc")
    .limit(1).first
  end
end


#Invoice.select("invoices.created_at, sum(invoice_items.quantity) AS units").joins(:invoice_items).where("invoice_items.item_id = #{id}").group("invoices.id").order("units desc, invoices.created_at desc").limit(1).first
