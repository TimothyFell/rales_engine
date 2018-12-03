class CustomerTransactionsSerializer
  include FastJsonapi::ObjectSerializer
  attributes :id, :first_name, :last_name
  has_many :transactions
end
