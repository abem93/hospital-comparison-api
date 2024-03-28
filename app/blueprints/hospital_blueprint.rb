# frozen_string_literal: true

class HospitalBlueprint < Blueprinter::Base
  identifier :id

  view :normal do
    fields :hospital_name
    association :address, blueprint: AddressBlueprint, view: :normal
  end

end