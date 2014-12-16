class AddAtHomeToChoices < ActiveRecord::Migration
  def change
    add_column :choices, :at_home, :boolean, default: false
  end
end
