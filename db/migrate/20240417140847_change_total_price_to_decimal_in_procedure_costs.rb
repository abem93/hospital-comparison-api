class ChangeTotalPriceToDecimalInProcedureCosts < ActiveRecord::Migration[7.1]
  def change
    change_column :procedure_costs, :total_price, :decimal
  end
end
