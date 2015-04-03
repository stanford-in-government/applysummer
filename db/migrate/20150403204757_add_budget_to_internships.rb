class AddBudgetToInternships < ActiveRecord::Migration
  def change
    add_column :internships, :budget, :text
  end
end
