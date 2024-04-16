require 'csv'

#one to many cpt to hospital
#description

# module DataHandler 
#   csv_file_path = '../data/440577118_Cox_Medical_Centers_Springfield_standardcharges_PH203Nq.csv'
#   row_count = 0
#   cox_data = []
#   CSV.foreach(csv_file_path,  headers: true, encoding: 'ISO-8859-1') do |row|
#     # Access each row as a hash with headers as keys
#     if row['CPT/HCPCs']
#       description = row['Description'].rstrip
#       cox_data.push ("Description: #{description}, CPT/HCPCs: #{row['CPT/HCPCs']}, Self Pay Rate: #{row['Self Pay Rate ']}, Gross Price: #{row['Price Per Unit']}, Minimum Rate: #{row['Minimum Rate ']}, Maximum Rate: #{row['Maximum Rate ']}, Hospital:'Cox'")
      
#       row_count += 1
#     end
#     break if row_count == 2
#   end
#   puts cox_data
# end
