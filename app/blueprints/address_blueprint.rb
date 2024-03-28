# frozen_string_literal: true

class AddressBlueprint < Blueprinter::Base
  identifier :id

  view :normal do
    fields :street_address, :line2, :city, :state, :zipcode
  end
end
