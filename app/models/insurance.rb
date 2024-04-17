class Insurance < ApplicationRecord
  validates :name, presence: true

  has_many :insurance_procedure_costs
  has_many :procedure_costs, through: :insurance_procedure_costs
end