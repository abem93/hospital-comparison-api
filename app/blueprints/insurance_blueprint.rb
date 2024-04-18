# frozen_string_literal: true

class InsuranceBlueprint < Blueprinter::Base
  identifier :id
  fields :name
  
  view :normal do
    fields :name
  end
end
