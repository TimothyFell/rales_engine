class Api::V1::Customers::CustomerSearchController < ApplicationController

  def index
    render json: CustomerSerializer.new(Customer.where(look_up_params))
  end

  def show
    if !look_up_params.empty?
      render json: CustomerSerializer.new(Customer.find_by(look_up_params))
    else
      render json: CustomerSerializer.new(Customer.random)
    end

  end

  private

    def look_up_params
      params.permit('id','first_name', 'last_name','created_at', 'updated_at')
    end

end
