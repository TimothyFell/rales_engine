class Api::V1::InvoiceItemsController < ApplicationController
  def index
    data = InvoiceItem.all
    render json: InvoiceItemSerializer.new(data)
  end
  def show
    data = InvoiceItem.find(paprams[:id])
    render json: InvoiceItemSerializer.new(data)
  end
end
