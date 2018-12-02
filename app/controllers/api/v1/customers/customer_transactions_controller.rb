class Api::V1::Customers::CustomerTransactionsController < ApplicationController

  def show
    options = {}
    options[:include] = [:'invoices.transactions']
    render json: CustomerTransactionsSerializer.new(Customer.find(params[:id]), options).serializable_hash
  end

end
