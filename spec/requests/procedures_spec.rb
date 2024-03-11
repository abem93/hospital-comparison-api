require 'rails_helper'

RSpec.describe "Procedures", type: :request do
   # get procedures - index
   describe "GET /procedures" do
    it 'returns a response with all the procedures' do
      create(:procedure)
      get '/procedures'
      expect(response.body).to eq(ProceduresBlueprint.render(Procedure.all, view: :normal))
    end
  end

  # get procedure - show
  describe "GET /procedure" do
    let (:procedure) {create(:procedure)}

    it "returns a response with the specific procedure" do
      get "/procedures/#{procedure.id}"
      expect(response.body).to eq(ProceduresBlueprint.render(procedure, view: :extended))
    end
  end
end
