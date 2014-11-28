class CreateOrganizations < ActiveRecord::Migration
  def change
    create_table :organizations do |t|
      t.string :name
      t.string :url
      t.integer :category, default: 0
      t.string :description
      t.string :city
      t.string :state

      t.timestamps
    end
  end
end
