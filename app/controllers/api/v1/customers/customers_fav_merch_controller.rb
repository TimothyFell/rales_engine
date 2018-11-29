class Api::V1::Customers::CustomersFavMerchController < ApplicationController
  def show
    render json: Customer.customers_fav_merch(params[:id])
  end
end
