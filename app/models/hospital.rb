class Hospital < ApplicationRecord
  validates :hospital_name, presence: true

  has_one :addresses
end
