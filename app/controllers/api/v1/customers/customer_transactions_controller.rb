class Api::V1::Customers::CustomerTransactionsController < ApplicationController

  def show
    render json: CustomerTransactionsSerializer.new(Customer.find(params[:id]))
  end

end
