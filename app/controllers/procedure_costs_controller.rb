class ProcedureCostsController < ApplicationController
  
  before_action :set_procedure, only: [:show]

  def show 
    render json: ProceduresBlueprint.render(@procedure, view: :normal), status: :ok
  end
  

  private

  def set_procedure
    @procedure = Procedure_costs.find(params[:id])
  end
end
