class Api::V1::Invoices::InvoiceSearchController < ApplicationController
  def index
    render json: InvoiceSerializer.new(Invoice.where(look_up_params))
  end

  def show
    if !look_up_params.empty?
      render json: InvoiceSerializer.new(Invoice.find_by(look_up_params))
    else
      render json: InvoiceSerializer.new(Invoice.random)
    end
  end

  private

  def look_up_params
    params.permit('id','merchant_id','customer_id','created_at', 'updated_at')
  end

end
