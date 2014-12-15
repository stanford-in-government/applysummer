class ChangeInternships < ActiveRecord::Migration
  def change
    change_column :internships, :financial_aid, :boolean, default: false
  end
end
