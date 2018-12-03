class MerchantBestRevenueSerializer
  include FastJsonapi::ObjectSerializer
  attributes :id, :name

  attribute :revenue do |object|
    object.revenue.to_s.prepend('$')
  end
end
