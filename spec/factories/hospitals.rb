FactoryBot.define do
  factory :hospital do
    hospital_name { Faker::Bank.name }
    address { build(:address) }
  end
end
