class Api::V1::Items::ItemsBestDayController < ApplicationController
  def show
    render json: ItemsBestDaySerializer.new(Item.best_day(params[:id]))
  end
end
