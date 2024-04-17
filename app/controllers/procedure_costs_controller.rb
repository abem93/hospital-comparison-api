class ProcedureCostsController < ApplicationController
  
  before_action :set_procedure, only: [:index, :show]

  def index
    render json: ProcedureCostBlueprint.render(@procedure, view: :normal), status: :ok
  end

  def show 
    render json: ProceduresBlueprint.render(@procedure, view: :normal), status: :ok
  end
  

  private

  def set_procedure
    @procedure = Procedure.find(params[:id])
    @procedure = @procedure.procedure_costs
  end
end
