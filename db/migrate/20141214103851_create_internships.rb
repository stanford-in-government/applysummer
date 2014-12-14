class CreateInternships < ActiveRecord::Migration
  def change
    create_table :internships do |t|
      t.references :application, index: true
      t.string :name
      t.string :city
      t.string :country
      t.string :supervisor_name
      t.string :supervisor_title
      t.string :supervisor_email
      t.string :supervisor_phone
      t.string :faculty_name
      t.boolean :financial_aid
      t.boolean :unpaid
      t.boolean :minimum_length
      t.boolean :fulltime
      t.boolean :travel_warning
      t.boolean :political
      t.boolean :social_service
      t.string :category
      t.string :related_to
      t.text :work_scope
      t.text :relevance
      t.text :reason

      t.timestamps
    end
  end
end
