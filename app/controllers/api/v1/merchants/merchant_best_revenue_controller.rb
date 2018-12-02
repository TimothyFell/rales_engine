class Api::V1::Merchants::MerchantBestRevenueController < ApplicationController
  def index
    data = Merchant.best_revenue(params[:quantity])
    render json: MerchantBestRevenueSerializer.new(data)
  end
end
