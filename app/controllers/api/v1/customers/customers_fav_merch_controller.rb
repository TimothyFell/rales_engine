class Api::V1::Customers::CustomersFavMerchController < ApplicationController
  def show
    og_json = Customer.customers_fav_merch(params[:id])
    render json: CustomersFavMerchSerializer.new(og_json)
  end
end
