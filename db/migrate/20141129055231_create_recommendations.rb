class CreateRecommendations < ActiveRecord::Migration
  def change
    create_table :recommendations do |t|
      t.string :email
      t.string :name
      t.references :application, index: true
      t.string :text

      t.timestamps
    end
  end
end
