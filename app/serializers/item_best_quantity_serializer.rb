class ItemBestQuantitySerializer
  include FastJsonapi::ObjectSerializer
  attributes :id, :name, :description, :unit_price, :merchant_id, :number_sold
end
