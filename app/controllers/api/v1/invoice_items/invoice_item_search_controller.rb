class Api::V1::InvoiceItems::InvoiceItemSearchController< ApplicationController
  def index
    render json: InvoiceItemSerializer.new(InvoiceItem.where(look_up_params))
  end

  def show
    if !look_up_params.empty?
      render json: InvoiceItemSerializer.new(InvoiceItem.find_by(look_up_params))
    else
      render json: InvoiceItemSerializer.new(InvoiceItem.random)
    end
  end


    private

      def look_up_params
        params.permit("id", "name", "item_id", "invoice_id", "unit_price", "quantity", "created_at", "updated_at")
      end
end
