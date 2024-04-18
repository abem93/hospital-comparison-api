# frozen_string_literal: true

class InsuranceProcedureCostBlueprint < Blueprinter::Base
  identifier :id
  fields :price
  association :insurance, blueprint: InsuranceBlueprint, view: :normal
end
