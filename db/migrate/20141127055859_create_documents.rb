class CreateDocuments < ActiveRecord::Migration
  def change
    create_table :documents do |t|
      t.integer :category, default: 0
      t.references :user, index: true

      t.timestamps
    end
  end
end
