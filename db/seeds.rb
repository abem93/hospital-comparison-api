(1..10).each do |i|
  procedure = Procedure.create(
    name: Faker::Internet.word, 
    cpt_code: Faker::Internet.word + i.to_s,
    department: Faker::Internet.word
  )
end