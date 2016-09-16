class Resident < ApplicationRecord
  has_many :chores
  
  validates :name, presence: true
  validates :email, presence: true
end
