class InsuranceProcedureCost < ApplicationRecord
  belongs_to :insurance
  belongs_to :procedure_cost

  validates :price, presence: true, numericality: { only_float: true}
end

