class Api::V1::TransactionsController < ApplicationController
  def index
    data = Transaction.all
    render json: TransactionSerializer.new(data)
  end

  def show
    data = Transaction.find(params[:id])
    render json: TransactionSerializer.new(data)
  end
end
