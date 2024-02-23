class ProcedureCost < ApplicationRecord
  belongs_to :procedure
  belongs_to :hospital
  belongs_to :insurance
end
