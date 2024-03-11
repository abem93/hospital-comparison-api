class InsurancesController < ApplicationController
  before_action :set_insurance, only: [:show]
  def index
    insurances = Insurance.all
    render json: InsuranceBlueprint.render(insurances, view: :normal), status: :ok
  end

  def show 
    render json: InsuranceBlueprint.render(@insurance, view: :extended), status: :ok
  end

  private

  def set_insurance
    @insurance = Insurance.find(params[:id])
  end
end
