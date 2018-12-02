class ItemsBestDaySerializer
  include FastJsonapi::ObjectSerializer
  attribute :best_day, &:created_at
end
