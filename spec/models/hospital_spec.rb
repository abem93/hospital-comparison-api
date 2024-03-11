require 'rails_helper'

RSpec.describe Hospital, type: :model do
  context "validation tests" do 
    
    it 'is not valid without a hospital name' do 
      hospital = build(:hospital, hospital_name: nil)
      expect(hospital).not_to be_valid
    end

    it ' is not valid without an address' do
      hospital = build(:hospital, address: nil)

      expect(hospital).not_to be_valid
    end
  end
end
