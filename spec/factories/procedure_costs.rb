FactoryBot.define do
  factory :procedure_cost do
    total_price { Faker::Number.decimal(l_digits: 2, r_digits: 2) }
    procedure_id { create(:procedure).id }
    hospital_id { create(:hospital).id }
    insurance_id { create(:insurance).id }
    

  end
end
