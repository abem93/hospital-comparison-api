require 'csv'


module DataHandler 
  csv_file_path = '../data/431704371_Freeman-Health-System_standardcharges.csv'

  row_count= 0
  freeman_data = []
  CSV.foreach(csv_file_path, headers: true) do |row|
    # Access each row as a hash with headers as keys
    if row['Code'].length == 5 && row['Discounted cash price'] != "N/A" && row['Package/Line_Level'] != "Package"
      description = row['Description'].rstrip
      cpt_code = row['Code']
      # freeman_data.push cpt_code

      #Display Data
      freeman_data.push "Description: #{description}, CPT: #{row['Code']}, Self Pay Rate: #{row['Discounted cash price']}, Gross Price: #{row['Gross charge']}, Minimum Rate: #{row['De-identified min contracted rate']}, Maximum Rate: #{row['De-identified max contracted rate']}, Hospital:'Freeman'"
    
      # ActiveRecord::Base.transaction do
      #   # Create a new Procedure
      #   procedure = Procedure.create(
      #     name: description, 
      #     cpt_code: cpt_code,
      #   )
      
      #   # Find or create the insurance
      #   self_pay = Insurance.find_or_create_by(name: 'Self Pay')
      #   self_pay.price = row['Discounted cash price']
      #   self_pay.save
      
      #   # Find the hospital
      #   hospital = Hospital.find_by(hospital_name: 'Freeman Health System')
      
      
      #   # Create a new ProcedureCost
      #   procedure_costs = ProcedureCost.new
      #   procedure_costs.procedure = procedure
      #   procedure_costs.hospital = hospital
      #   procedure_costs.total_price = row['Gross charge']
      #   procedure_costs.insurance = self_pay
      #   procedure_costs.save
      # end
      row_count += 1
    end
    break if row_count == 4
  end
  puts freeman_data
end