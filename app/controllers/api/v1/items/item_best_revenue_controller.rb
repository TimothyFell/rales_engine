class Api::V1::Items::ItemBestRevenueController < ApplicationController
  def index
    data = Item.best_revenue(params[:quantity])
    render json: ItemBestRevenueSerializer.new(data)
  end
end
