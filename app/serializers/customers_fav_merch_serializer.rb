class CustomersFavMerchSerializer
  include FastJsonapi::ObjectSerializer

  attribute :id, :name
end
