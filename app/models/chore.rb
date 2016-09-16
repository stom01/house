class Chore < ApplicationRecord
  belongs_to :resident
  
  validates :name, presence: true
end
