class ProcedureCost < ApplicationRecord
  validates :total_price, presence: true, numericality: { only_float: true, format: { with: /\A\d+\.\d{2}\z/ } }

  belongs_to :procedure
  belongs_to :hospital
  has_many :insurance_procedure_costs, dependent: :destroy
  has_many :insurances, through: :insurance_procedure_costs

  def to_s
    "Procedure ID: #{procedure_id}, Hospital ID: #{hospital_id}, Total Price: #{total_price}"
  end
end