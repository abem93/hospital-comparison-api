# frozen_string_literal: true

class ProceduresBlueprint < Blueprinter::Base
  identifier :id

  view :normal do
    fields :name, :cpt_code
  end

  view :extended do
    fields :name, :cpt_code, :department
  end
end
