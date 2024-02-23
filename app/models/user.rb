class User < ApplicationRecord
  validates :username, presence: true,
  validates :email,
  
end
