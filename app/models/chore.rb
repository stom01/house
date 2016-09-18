class Chore < ApplicationRecord
  belongs_to :resident, touch: true, optional: true

  validates :name, presence: true
end
