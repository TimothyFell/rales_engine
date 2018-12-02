class TransactionSerializer
  include FastJsonapi::ObjectSerializer
  attributes :id
  belongs_to :invoice
end
