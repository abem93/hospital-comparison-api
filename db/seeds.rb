require 'csv'
require 'json'

self_pay = Insurance.new(name: 'Self Pay').save
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
    hospital_data = Hospital.create(
      hospital_name: hospital[:hospital_name],
    )
    address = Address.new(hospital[:address])
    address.street_address = hospital[:address][:street_address]
    address.city = hospital[:address][:city]
    address.state = hospital[:address][:state]
    address.zipcode = hospital[:address][:zipcode]
    address.save
    hospital_data.address = address
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
      procedure = Procedure.create(
        name: description, 
        cpt_code: cpt_code,
      )
    
      # Find or create the insurance
      self_pay = Insurance.find_or_create_by(name: 'Self Pay')
      self_pay.price = row['Discounted cash price']
      self_pay.save
    
      # Find the hospital
      hospital = Hospital.find_by(hospital_name: 'Freeman Health System')
    
    
      # Create a new ProcedureCost
      procedure_costs = ProcedureCost.new
      procedure_costs.procedure = procedure
      procedure_costs.hospital = hospital
      procedure_costs.total_price = row['Gross charge']
      procedure_costs.insurance = self_pay
      procedure_costs.save
    end
  end
end


cox_data = []
freeman_cpt_codes = freeman_data.map { |data| data[1] }
row_count = 0
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
        self_pay = Insurance.find_or_create_by(name: 'Self Pay')
        self_pay.price = row['Self Pay Rate ']
        self_pay.save
      
        # Find the hospital
        hospital = Hospital.find_by(hospital_name: 'CoxHealth Medical Center South')
      
      
        # Create a new ProcedureCost
        procedure_costs = ProcedureCost.new
        procedure_costs.procedure = procedure
        procedure_costs.hospital = hospital
        procedure_costs.total_price = row['Price Per Unit']
        procedure_costs.insurance = self_pay
        procedure_costs.save
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
      freeman_cpt_codes.each do |freeman_code|
        if data['NriDrgCptCode'] == freeman_code && !mercy_data.any? { |mercy_data| mercy_data['NriDrgCptCode'] == data['NriDrgCptCode'] }
          mercy_data.push(data)
          ActiveRecord::Base.transaction do
            # Find the Procedure
            procedure = Procedure.find_by(cpt_code: data['NriDrgCptCode'])
            
            # Find or create the insurance
            self_pay = Insurance.find_or_create_by(name: 'Self Pay')
            self_pay.price = data['SelfPay']
            self_pay.save
          
            # Find the hospital
            hospital = Hospital.find_by(hospital_name: 'Mercy Hospital Springfield')
          
          
            # Create a new ProcedureCost
            procedure_costs = ProcedureCost.new
            procedure_costs.procedure = procedure
            procedure_costs.hospital = hospital
            procedure_costs.total_price = data['UnitCharge']
            procedure_costs.insurance = self_pay
            procedure_costs.save
          end
        end
      end
    end
  end
end




unmatched_freeman_data = freeman_data.reject do |description, cpt_code|
  cox_data.any? { |data| data.include?("CPT/HCPCs: #{cpt_code}") } ||
  mercy_data.any? { |data| data['NriDrgCptCode'] == cpt_code }
end

unmatched_freeman_data.each do |data|
    ActiveRecord::Base.transaction do
      # Find the Procedure
      procedure = Procedure.find_by(cpt_code: data[1])
      
      # Delete the related ProcedureCost records
      procedure.procedure_costs.destroy_all if procedure.present?
      
      # Delete the unused Procedure
      procedure.destroy if procedure
    end
end