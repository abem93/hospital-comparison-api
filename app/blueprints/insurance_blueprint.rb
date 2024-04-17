# frozen_string_literal: true

class InsuranceBlueprint < Blueprinter::Base
  identifier :id

  view :normal do
    fields :name
  end
end
