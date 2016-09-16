class AddResidentidToChores < ActiveRecord::Migration[5.0]
  def change
    add_column :chores, :resident_id, :integer
  end
end
