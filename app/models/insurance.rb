class Insurance < ApplicationRecord
  validates :name, presence: true
  validates :price, presence: true, numericality: { only_float: true}
end
