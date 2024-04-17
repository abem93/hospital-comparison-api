class RemovePriceFromInsurance < ActiveRecord::Migration[7.1]
  def change
    remove_column :insurances, :price, :decimal
  end
end
