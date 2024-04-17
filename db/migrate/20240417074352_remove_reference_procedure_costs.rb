class RemoveReferenceProcedureCosts < ActiveRecord::Migration[7.1]
  def change
    remove_reference :procedure_costs, :insurance, foreign_key: true
  end
end
