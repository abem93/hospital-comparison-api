class CreateAddresses < ActiveRecord::Migration[7.1]
  def change
    create_table :addresses do |t|
      t.string :street_address
      t.string :line2
      t.string :city
      t.string :state
      t.string :zipcode
      t.references :hospital, null: false, foreign_key: true

      t.timestamps
    end
  end
end
