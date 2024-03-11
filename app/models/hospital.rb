class Hospital < ApplicationRecord
  validates :hospital_name, presence: true

  has_one :address, required: true

end
