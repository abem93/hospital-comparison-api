# frozen_string_literal: true

class ProcedureCostBlueprint < Blueprinter::Base
  identifier :id

  view :normal do
    fields  :total_price

    association :hospital, blueprint: HospitalBlueprint, view: :normal
    association :procedure, blueprint: ProceduresBlueprint, view: :normal
    association :insurance, blueprint: InsuranceBlueprint, view: :extended
  end

 
  
end
