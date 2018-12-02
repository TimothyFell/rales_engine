class MerchantBestRevenueSerializer
  include FastJsonapi::ObjectSerializer
  attributes :id, :name, :revenue
end
