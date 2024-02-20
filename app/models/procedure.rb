class Procedure < ApplicationRecord
  validates :name, presence:true
  validates :cpt_code presence:true
end
