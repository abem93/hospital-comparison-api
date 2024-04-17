class Procedure < ApplicationRecord
  validates :name, presence:true
  validates :cpt_code, presence: true

  has_many :procedure_costs
  has_many :hospitals, through: :procedure_costs
end
