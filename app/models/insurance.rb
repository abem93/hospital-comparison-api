class Insurance < ApplicationRecord
  validates :name, presence: true
  validates :price, presence: true, numericality: { only_float: true}

  has_many :procedure_costs
  has_many :hospitals, through: :procedure_costs
end
