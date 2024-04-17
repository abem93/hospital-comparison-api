class RemoveProcedureReferenceFromInsurance < ActiveRecord::Migration[7.1]
  def change
    remove_reference :insurances, :procedure_cost, index: true, foreign_key: true
  end
end
