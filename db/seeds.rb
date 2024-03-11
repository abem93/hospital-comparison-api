(1..3).each do |i|
  hospital = Hospital.create(hospital_name: Faker::Company.name)
  hospital.save
  address = Address.new(
    street_address: Faker::Address.street_address,
    line2: Faker::Address.secondary_address,
    city: Faker::Address.city,
    state: Faker::Address.state,
    zipcode: Faker::Address.zip
  )
  address.hospital = hospital
  address.save

  (1..3).each do |j|
    Procedure.create(
      cpt_code: Faker::Code.ean,
      name: Faker::Lorem.sentence,
      department: Faker::Lorem.word
    )
  end
  (1..3).each do |j|
    Insurance.create(
      name: Faker::Bank.name,
      price: Faker::Number.decimal(l_digits: 2, r_digits: 2)
    )
  end

end