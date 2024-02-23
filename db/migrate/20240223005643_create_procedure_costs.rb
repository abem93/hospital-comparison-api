class CreateProcedureCosts < ActiveRecord::Migration[7.1]
  def change
    create_table :procedure_costs do |t|
      t.references :procedure, null: false, foreign_key: true
      t.references :hospital, null: false, foreign_key: true
      t.string :total_price
      t.references :insurance, null: false, foreign_key: true

      t.timestamps
    end
  end
end
