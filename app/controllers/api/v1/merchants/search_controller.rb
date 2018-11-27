class Api::V1::Merchants::SearchController < ApplicationController

  def index

  end

  def show
    render json: Merchant.look_up(params)
  end

end
