class CreateProcedures < ActiveRecord::Migration[7.1]
  def change
    create_table :procedures do |t|
      t.string :cpt_code
      t.string :name
      t.string :department

      t.timestamps
    end
  end
end
