require 'rails_helper'

RSpec.describe Address, type: :model do
  context "validation tests" do 
    it 'is not valid without a street address' do 
      address = build(:address, street_address: nil)

      expect(address).not_to be_valid
    end

    it 'is not valid without a city' do 
      address = build(:address, city: nil)

      expect(address).not_to be_valid
    end

    it 'is not valid without a state' do 
      address = build(:address, state: nil)

      expect(address).not_to be_valid
    end

    it 'is not valid without a zipcode' do 
      address = build(:address, zipcode: nil)

      expect(address).not_to be_valid
    end

  end
end
