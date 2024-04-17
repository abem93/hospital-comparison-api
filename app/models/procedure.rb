class Procedure < ApplicationRecord
  validates :name, presence:true
  validates :cpt_code, presence: true

  has_many :procedure_costs, dependent: :destroy
  has_many :insurance_procedure_costs, through: :procedure_costs, source: :insurance_procedure_costs
end
