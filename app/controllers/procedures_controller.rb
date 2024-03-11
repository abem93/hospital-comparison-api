class ProceduresController < ApplicationController

  before_action :set_procedure, only: [:show]
  def index
    procedures = Procedure.all
    render json: ProceduresBlueprint.render(procedures, view: :normal), status: :ok
  end

  def show 
    render json: ProceduresBlueprint.render(@procedure, view: :extended), status: :ok
  end
  

  private

  def set_procedure
    @procedure = Procedure.find(params[:id])
  end
end
