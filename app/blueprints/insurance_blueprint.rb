# frozen_string_literal: true

class InsuranceBlueprint < Blueprinter::Base
  identifier :id

  view :normal do
    fields :name
  end

  view :extended do
    fields :name, :price
  end
end
