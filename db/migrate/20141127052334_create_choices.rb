class CreateChoices < ActiveRecord::Migration
  def change
    create_table :choices do |t|
      t.integer :rank
      t.string :statement
      t.string :budget
      t.references :organization, index: true
      t.references :application, index: true

      t.timestamps
    end
  end
end
