class CreateApplications < ActiveRecord::Migration
  def change
    create_table :applications do |t|
      t.integer :category, default: 0
      t.integer :status, default: 0
      t.string :rec_code
      t.references :user, index: true

      t.timestamps
    end
  end
end
