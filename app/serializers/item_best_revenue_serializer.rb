class ItemBestRevenueSerializer
  include FastJsonapi::ObjectSerializer
  attributes :id, :name, :description, :unit_price, :merchant_id

  attribute :revenue do |object|
    object.revenue.to_s.prepend('$')
  end
end
