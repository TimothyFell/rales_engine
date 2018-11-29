FactoryBot.define do
  factory :customer do
    first_name { Faker::Name.first_name  }
    last_name { Faker::GameOfThrones.house }
  end
end
