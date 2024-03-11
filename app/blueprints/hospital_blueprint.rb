# frozen_string_literal: true

class HospitalBlueprint < Blueprinter::Base
  identifier :id

  view :normal do
    fields :hospital_name
  end

  view :extended do
    fields :hospital_name, :address
  end

end