class Api::V1::Items::ItemMerchantController < ApplicationController
  def show
    render json: ItemMerchantSerializer.new(Item.find(params[:id]))
  end
end
