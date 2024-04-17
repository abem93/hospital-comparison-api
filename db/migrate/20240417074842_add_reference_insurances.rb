class AddReferenceInsurances < ActiveRecord::Migration[7.1]
  def change
    add_reference :insurances, :procedure_cost, foreign_key: true
  end
end
