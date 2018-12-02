class InvoiceSerializer
  include FastJsonapi::ObjectSerializer
  attributes :id
  has_many :transactions
end
