class ProcedureCost < ApplicationRecord
  validates :total_price, presence: true, numericality: { only_float: true, format: { with: /\A\d+\.\d{2}\z/ } }

  belongs_to :procedure, required: true
  belongs_to :hospital,  required: true
  belongs_to :insurance, required: true
end
