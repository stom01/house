class CreateChores < ActiveRecord::Migration[5.0]
  def change
    create_table :chores do |t|
      t.string :name, null: false
      t.text :description
      t.integer :resident_id

      t.timestamps
    end
  end
end
