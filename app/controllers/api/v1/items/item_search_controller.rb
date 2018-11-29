class Api::V1::Items::ItemSearchController < ApplicationController
  
  def index
    render json: Item.where(look_up_params)

  end

  def show
    render json: Item.find(look_up_params)
  end

  private

    def look_up_params
      params.permit("id", "name", "description", "unit_price", "merchant_id", "created_at", "updated_at")
    end
end
