class HospitalsController < ApplicationController
  before_action :set_hospital, only: [:show]
  def index
    hospitals = Hospital.all
    render json: HospitalBlueprint.render(hospitals, view: :normal), status: :ok
  end

  def show 
    @hospital
    render json: HospitalBlueprint.render(@hospital, view: :normal), status: :ok
  end

  private

  def set_hospital
    @hospital = Hospital.find(params[:id])
  end
end
