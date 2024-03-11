# frozen_string_literal: true

class UserBlueprint < Blueprinter::Base
  identifier :id

  view :me do
    fields  :email, :zipcode
  end
  view :normal do
    fields :email
  end

end
