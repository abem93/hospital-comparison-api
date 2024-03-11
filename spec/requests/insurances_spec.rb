require 'rails_helper'

RSpec.describe "Insurances", type: :request do
   # get insurances - index
   describe "GET /insurances" do
    it 'returns a response with all the insurances' do
      create(:insurance)
      get '/insurances'
      expect(response.body).to eq(InsuranceBlueprint.render(Insurance.all, view: :normal))
    end
  end

  # get insurance - show
  describe "GET /insurance" do
    let (:insurance) {create(:insurance)}

    it "returns a response with the specific insurance" do
      get "/insurances/#{insurance.id}"
      expect(response.body).to eq(InsuranceBlueprint.render(insurance, view: :extended))
    end
  end
end
