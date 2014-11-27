class CreateProfiles < ActiveRecord::Migration
  def change
    create_table :profiles do |t|
      t.references :user, index: true
      t.string :first_name
      t.string :middle_name
      t.string :last_name
      t.string :local_street
      t.string :local_city
      t.string :local_state
      t.string :local_postal
      t.string :perm_street
      t.string :perm_city
      t.string :perm_state
      t.string :perm_country
      t.string :perm_postal
      t.string :majors
      t.string :minors
      t.integer :class_year
      t.float :overall_gpa
      t.float :major_gpa

      t.timestamps
    end
  end
end
