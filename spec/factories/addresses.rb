FactoryBot.define do
  factory :address do
    street_address { Faker::Address.street_address }
    city { Faker::Address.city }
    state { Faker::Address.state }
    zipcode { Faker::Address.zip }
    
  end
end
