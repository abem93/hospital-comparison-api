class CreateInsuranceProcedureCostsrails < ActiveRecord::Migration[7.1]
  def change
    create_table :insurance_procedure_costs do |t|
      t.references :insurance, null: false, foreign_key: true
      t.references :procedure_cost, null: false, foreign_key: true
      t.decimal :price

      t.timestamps
    end
  end
end
