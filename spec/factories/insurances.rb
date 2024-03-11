FactoryBot.define do
  factory :insurance do
    name {Faker::Bank.name}
    price {Faker::Number.decimal(l_digits: 2, r_digits: 2)}
  end
end
