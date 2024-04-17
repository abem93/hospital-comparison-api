class Hospital < ApplicationRecord
  validates :hospital_name, presence: true

  has_one :address

  has_many :procedure_costs
  has_many :procedures, through: :procedure_costs

end
