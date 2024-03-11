FactoryBot.define do
  factory :user do
    email { Faker::Internet.email }
    zipcode { Faker::Number.number(digits: 5) }
    password { 'password' }
    password_confirmation { 'password' }
  end
end
