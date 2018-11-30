class Api::V1::Merchants::MerchantSearchController < ApplicationController

  def index
    render json: Merchant.where(look_up_params)
  end

  def show
    if look_up_params != nil
      render json: Merchant.find_by(look_up_params)
    else
      render json: Merchant.random
    end
  end

  private

    def look_up_params
      params.permit('id','name','created_at', 'updated_at')
    end

end
