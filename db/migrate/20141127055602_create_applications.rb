class CreateApplications < ActiveRecord::Migration
  def change
    create_table :applications do |t|
      t.integer :category, default: 0
      t.integer :status, default: 0
      t.string :rec_code, index: true, unique: true
      t.string :pers_statement
      t.string :rel_coursework
      t.references :user, index: true

      t.timestamps
    end
  end
end
