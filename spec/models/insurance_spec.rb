require 'rails_helper'

RSpec.describe Insurance, type: :model do
  context "validation tests" do 
    it 'is not valid without a name' do
      insurance = build(:insurance, name: nil)

      expect(insurance).not_to be_valid
    end

    it 'is not valid without a price' do
      insurance = build(:insurance, price: nil)
      
      expect(insurance).not_to be_valid
    end

    it 'is not valid if price is not a number' do
      insurance = build(:insurance, price: "80%")

      expect(insurance).not_to be_valid
    end
  end
end
