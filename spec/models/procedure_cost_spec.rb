require 'rails_helper'

RSpec.describe ProcedureCost, type: :model do
  context "validation tests" do 
    it 'is not valid without a procedure' do
      procedure = build(:procedure_cost, procedure_id: nil)

      expect(procedure).not_to be_valid
    end

    it 'is not valid without a hospital' do
      procedure = build(:procedure_cost, hospital_id: nil)

      expect(procedure).not_to be_valid
    end

    it 'is not valid without an insurance' do
      procedure = build(:procedure_cost, insurance_id: nil)

      expect(procedure).not_to be_valid
    end

    it 'is not valid without a total price' do
      procedure = build(:procedure_cost, total_price: nil)

      expect(procedure).not_to be_valid
    end
  end
end
