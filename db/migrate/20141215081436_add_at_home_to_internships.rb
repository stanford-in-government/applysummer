class AddAtHomeToInternships < ActiveRecord::Migration
  def change
    add_column :internships, :at_home, :boolean, default: false
  end
end
