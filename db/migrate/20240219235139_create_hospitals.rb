class CreateHospitals < ActiveRecord::Migration[7.1]
  def change
    create_table :hospitals do |t|
      t.string :hospital_name

      t.timestamps
    end
  end
end
