require 'rails_helper'

RSpec.describe "Hospitals", type: :request do
  # get hospitals - index
  describe "GET /hospitals" do
    it 'returns a response with all the hospitals' do
      create(:hospital)
      get '/hospitals'
      expect(response.body).to eq(HospitalBlueprint.render(Hospital.all, view: :normal))
    end
  end

  let (:hospital) {create(:hospital, address: build(:address))}
  # get hospital - show
  describe "GET /hospital" do
    it "returns a response with the specific hospital" do
      get "/hospitals/#{hospital.id}"
      expect(response.body).to eq(HospitalBlueprint.render(hospital, view: :extended))
    end
  end
end
