class Address < ApplicationRecord
  validates :street_address, presence:true
  validates :city, presence:true
  validates :state, presence:true
  validates :zipcode, presence:true

  belongs_to :hospital
end
