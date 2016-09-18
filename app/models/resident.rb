class Resident < ApplicationRecord
  has_many :chores

  validates :name, presence: true
  validates :email, presence: true

  after_destroy :clean_associations

  def clean_associations
    Chore.where(resident_id: id).update_all(resident_id: nil)
  end
end
