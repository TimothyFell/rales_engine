class Api::V1::Merchants::MerchantBestQuantityController < ApplicationController
  def index
    data = Merchant.best_quantity(params[:quantity])
    render json: MerchantBestQuantitySerializer.new(data)
  end
end
