require 'rails_helper'

RSpec.describe Procedure, type: :model do
  context "validation tests" do 
    it 'is not valid without a cpt code' do 
      procedure = build(:procedure, cpt_code: nil)

      expect(procedure).not_to be_valid
    end

    it 'is not valid without a name' do 
      procedure = build(:procedure, name: nil)

      expect(procedure).not_to be_valid
    end
  end
end
