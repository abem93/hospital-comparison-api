require 'json'

module DataHandler 
  file_path = '../data/440552485_mercyhospitalspringfield_standardcharges.json'
  mercy_data = []
  begin
    # Read JSON data from the file
    json_data = JSON.parse(File.read(file_path))
    
    if json_data.is_a?(Hash) # Assuming the JSON data is a hash
      # Access the third nested object by the key(max and min rate)
      third_key = json_data.keys[2]
      third_object = json_data[third_key]
      third_object.each do |hash|
        if hash["SelfPay"] != ""
          puts hash
        end
      end
    end
  end
 

end