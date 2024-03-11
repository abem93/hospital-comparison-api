FactoryBot.define do
  factory :procedure do
    cpt_code { Faker::Number.number(digits: 5) }
    name { Faker::Job.title }
    department { Faker::Job.field}
  end
end
