class User < ApplicationRecord
  validates :email, presence: true, uniqueness: true
  validates :zipcode, length: { is: 5 }, 
end
