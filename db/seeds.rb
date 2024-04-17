require 'csv'
require 'json'



self_pay = Insurance.new(name: 'Self Pay')
self_pay.save

hospitals = [
  {
    hospital_name: 'CoxHealth Medical Center South', 
    address:{  
      street_address: "3801 S National Ave",
      city: "Springfield",
      state: "MO",
      zipcode: "65807"
    }
  }, 
  {
    hospital_name: "Mercy Hospital Springfield",
    address:{
      street_address: "1235 E Cherokee St",
      city: "Springfield",
      state: "MO",
      zipcode: "65804",
    }
  },
  {
    hospital_name: "Freeman Health System",
    address:{
      street_address: "1102 W 32nd St",
      city: "Joplin",
      state: "MO",
      zipcode: "64804",
    }
  }
] 
hospitals.each do |hospital|
  ActiveRecord::Base.transaction do
    hospital_data = Hospital.find_or_initialize_by(
      hospital_name: hospital[:hospital_name],
    )
    hospital_data.save
    address = Address.find_or_initialize_by(hospital[:address])
    address.street_address = hospital[:address][:street_address]
    address.city = hospital[:address][:city]
    address.state = hospital[:address][:state]
    address.zipcode = hospital[:address][:zipcode]
    address.save
    hospital_data.address = address
    hospital_data.save
  end
 
end

cox_csv_file_path = File.expand_path('../../data/440577118_Cox_Medical_Centers_Springfield_standardcharges_PH203Nq.csv', __FILE__)

freeman_csv_file_path = File.expand_path('../../data/431704371_Freeman-Health-System_standardcharges.csv', __FILE__)

mercy_jsonfile_path = File.expand_path('../../data/440552485_mercyhospitalspringfield_standardcharges.json', __FILE__)



row_count= 0
freeman_data = []
CSV.foreach(freeman_csv_file_path, headers: true) do |row|
  # Access each row as a hash with headers as keys
  if row['Code'] && row['Code'].length == 5 && row['Discounted cash price'] != "N/A" && row['Package/Line_Level'] != "Package"

    description = row['Description'].rstrip
    cpt_code = row['Code']
    freeman_data.push ( [description,cpt_code])

    #Display Data
    # freeman_data.push "Description: #{description}, CPT: #{row['Code']}, Self Pay Rate: #{row['Discounted cash price']}, Gross Price: #{row['Gross charge']}, Minimum Rate: #{row['De-identified min contracted rate']}, Maximum Rate: #{row['De-identified max contracted rate']}, Hospital:'Freeman'"
  
    ActiveRecord::Base.transaction do
      # Create a new Procedure
      procedure = Procedure.find_or_initialize_by(cpt_code: cpt_code)
      procedure.name = description
      procedure.save
    
      # Find or create the insurance
      self_pay = Insurance.find_or_create_by(name: 'Self Pay')
    
      # Find the hospital
      hospital = Hospital.find_by(hospital_name: 'Freeman Health System')
    
    
      # Create a new ProcedureCost
      procedure_costs = ProcedureCost.create(procedure_id: procedure.id, hospital_id: hospital.id, total_price: row['Gross charge'])
      

      # Create an entry in the join table
      insurance_procedure_cost = InsuranceProcedureCost.new(insurance_id: self_pay.id, price: row['Discounted cash price'].to_f, procedure_cost_id: procedure_costs.id)
      insurance_procedure_cost.procedure_cost = procedure_costs
      insurance_procedure_cost.save!
      procedure_costs.save!
      puts "InsuranceProcedureCost record created successfully. ID: #{insurance_procedure_cost.id}"
    end
  end
end


cox_data = []
freeman_cpt_codes = freeman_data.map { |data| data[1] }

 CSV.foreach(cox_csv_file_path, headers: true, encoding: 'ISO-8859-1') do |row|

  # Check if Cox data contains the CPT code from freeman data
  if row['CPT/HCPCs'] && freeman_cpt_codes.include?(row['CPT/HCPCs'])
    # Check if the CPT code is already present in cox_data
    unless cox_data.any? { |data| data.include?("CPT/HCPCs: #{row['CPT/HCPCs']}") }
      cox_data.push("CPT/HCPCs: #{row['CPT/HCPCs']}, Self Pay Rate: #{row['Self Pay Rate ']}, Price Per Unit: #{row['Price Per Unit']}, Description: #{row['Description']}")
      
      ActiveRecord::Base.transaction do
        # Find the Procedure
        procedure = Procedure.find_by(cpt_code: row['CPT/HCPCs'])
        
        # Find or create the insurance
        self_pay = Insurance.find_by(name: 'Self Pay')

        # Find the hospital
        hospital = Hospital.find_by(hospital_name: 'CoxHealth Medical Center South')
      
      
        # Create a new ProcedureCost
        procedure_costs = ProcedureCost.create(procedure_id: procedure.id, hospital_id: hospital.id, total_price: row['Price Per Unit'])

        # Create an entry in the join table
        insurance_procedure_cost = InsuranceProcedureCost.new(insurance_id: self_pay.id, price: row['Self Pay Rate '].to_f, procedure_cost_id: procedure_costs.id)
        insurance_procedure_cost.procedure_cost = procedure_costs
        insurance_procedure_cost.save!
        procedure_costs.save!
        puts "InsuranceProcedureCost record created successfully. ID: #{insurance_procedure_cost.id}"
      end
    end
  end
end



mercy_data = []
begin
  # Read JSON data from the file
  json_data = JSON.parse(File.read(mercy_jsonfile_path))

  # Check if the JSON data is a Hash
  if json_data.is_a?(Hash) 
    # Access the third nested object by the key(max and min rate)
    third_key = json_data.keys[2]
    third_object = json_data[third_key]
    
    # Only push data with self pay rate
    price_data = []
    third_object.each do |hash|
      if hash["SelfPay"] != ""
        price_data.push(hash)
      end
    end

    #Check if mercy data contains the CPT code from freeman data
    price_data.each do |data|
        if data['NriDrgCptCode'] && freeman_cpt_codes.include?(data['NriDrgCptCode'])
          mercy_data.push(data)
          total_price = data['UnitCharge'].gsub('$', '').to_f
          self_pay_rate = data['SelfPay'].gsub('$', '').to_f

          
          ActiveRecord::Base.transaction do
            # Find the Procedure
            procedure = Procedure.find_by(cpt_code: data['NriDrgCptCode'])
            
            # Find or create the insurance
            self_pay = Insurance.find_by(name: 'Self Pay')
          
            # Find the hospital
            hospital = Hospital.find_by(hospital_name: 'Mercy Hospital Springfield')

            begin
              ActiveRecord::Base.transaction do
                procedure_costs = ProcedureCost.create(procedure_id: procedure.id, hospital_id: hospital.id, total_price: total_price)

                # Check if the ProcedureCost was successfully created
                 if procedure_costs.persisted?
                   # Create an entry in the join table
                   begin
                     ActiveRecord::Base.transaction do
                       insurance_procedure_cost = InsuranceProcedureCost.new(insurance_id: self_pay.id, price: self_pay_rate, procedure_cost_id: procedure_costs.id)
                       # Save the InsuranceProcedureCost record
                       insurance_procedure_cost.procedure_cost = procedure_costs
                       insurance_procedure_cost.save!
                       procedure_costs.save!
                      
                       puts "InsuranceProcedureCost record created successfully. ID: #{insurance_procedure_cost.id}"
                      end
                      rescue => e
                     # Log or inspect the error message
                     puts "An error occurred while creating InsuranceProcedureCost records: #{e.message}"
                   end
                   
                 else
                   puts "ProcedureCost creation failed."
                 end
               end
              end
            rescue => e
              # Log or inspect the error message
              puts "An error occurred while creating InsuranceProcedureCost records: #{e.message}"
            end
            # Create a new ProcedureCost


        end
    end
  end
end

unmatched_freeman_data = freeman_data.reject do |description, cpt_code|
  cox_data.any? { |data| data.include?("CPT/HCPCs: #{cpt_code}") } ||
  mercy_data.any? { |data| data['NriDrgCptCode'] == cpt_code }
end
puts "Unmatched Procedures: #{unmatched_freeman_data}"
unmatched_freeman_data.each do |data|
  begin
    ActiveRecord::Base.transaction do
      # Find the Procedure
      procedure = Procedure.find_by(cpt_code: data[1])
      
      # Delete the associated InsuranceProcedureCosts records
   

      # Delete the related ProcedureCost records
      procedure.procedure_costs.destroy_all if procedure.present?
      
      # Delete the unused Procedure
      procedure.destroy if procedure

      puts "Procedure record deleted successfully. CPT Code: #{data[1]}"
    end
  rescue => e
  # Log or inspect the error message
  puts "An error occurred while deleting Procedure records: #{e.message}"
  end
end