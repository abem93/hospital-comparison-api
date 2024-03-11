class HospitalsController < ApplicationController
  before_action :set_hospital, only: [:show]
  def index
    hospitals = Hospital.all
    render json: HospitalBlueprint.render(hospitals, view: :normal), status: :ok
  end

  def show 
    @hospital = Hospital.includes(:address)
    render json: HospitalBlueprint.render(@hospital, view: :extended), status: :ok
  end

  private

  def set_hospital
    @hospital = Hospital.find(params[:id])
  end
end
