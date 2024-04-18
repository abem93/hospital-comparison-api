class ProcedureCostsController < ApplicationController
  
  before_action :set_procedure, only: [:index, :show]

  def index
    @procedure_costs = @procedure.procedure_costs.includes(:insurance_procedure_costs => :insurance)
    render json: ProcedureCostBlueprint.render(@procedure_costs, view: :normal, root: :procedure_costs, insurance_procedure_costs: { include: { insurance: { except: [:created_at, :updated_at]} } }), status: :ok
  end

  def show 
    render json: ProcedureCostBlueprint.render(@procedure, view: :normal), status: :ok
  end
  

  private

  def set_procedure
    @procedure = Procedure.find(params[:id])
  end
end