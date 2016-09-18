class Chore < ApplicationRecord
  belongs_to :resident, optional: true

  validates :name, presence: true
end
