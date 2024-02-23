class AddPriceToInsurance < ActiveRecord::Migration[7.1]
  def change
    add_column :insurances, :price, :float
  end
end
