class ProceduresController < ApplicationController
  def index
    find_by_name
  
    if @procedures.nil?
      render json: { errors: "Procedure not found" }, status: :unprocessable_entity
    else
      render json: ProceduresBlueprint.render(@procedures, view: :normal), status: :ok
    end
  end

  def show 
    render json: ProceduresBlueprint.render(@procedure, view: :extended), status: :ok
  end
  

private
  def find_by_name
    search = params[:name]
    if search.match?(/\A\d+\z/) # Check if the search term includes is a number
      @procedures = Procedure.where("cpt_code LIKE ?", "%#{search}%")
    else
      @procedures = Procedure.where("name LIKE ?", "%#{search}%")
    end
  end

end
