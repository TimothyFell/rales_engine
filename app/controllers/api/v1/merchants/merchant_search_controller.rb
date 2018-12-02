class Api::V1::Merchants::MerchantSearchController < ApplicationController

  def index
    render json: MerchantSerializer.new(Merchant.where(look_up_params))
  end

  def show
    if look_up_params != nil
      render json: MerchantSerializer.new(Merchant.find_by(look_up_params))
    else
      render json: MerchantSerializer.new(Merchant.random)
    end
  end

  private

    def look_up_params
      params.permit('id','name','created_at', 'updated_at')
    end

end
