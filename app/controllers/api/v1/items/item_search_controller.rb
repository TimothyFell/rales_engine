class Api::V1::Items::ItemSearchController < ApplicationController

  def index
    render json: ItemSerializer.new(Item.where(look_up_params))

  end

  def show
    if look_up_params != nil
      render json: ItemSerializer.new(Item.find_by(look_up_params))
    else
      render json: ItemSerializer.new(Item.random)
    end
  end

  private

    def look_up_params
      params.permit("id", "name", "description", "unit_price", "merchant_id", "created_at", "updated_at")
    end
end
