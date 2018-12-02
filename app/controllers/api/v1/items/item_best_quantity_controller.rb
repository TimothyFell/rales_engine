class Api::V1::Items::ItemBestQuantityController < ApplicationController
  def index
    data = Item.best_quantity(params[:quantity].to_i)
    render json: ItemBestQuantitySerializer.new(data)
  end
end
