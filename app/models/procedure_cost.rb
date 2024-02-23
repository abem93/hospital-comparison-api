class ProcedureCost < ApplicationRecord
  validates :total_price, presence: true, numericality: { only_float: true}

  belongs_to :procedure
  belongs_to :hospital
  belongs_to :insurance
end
