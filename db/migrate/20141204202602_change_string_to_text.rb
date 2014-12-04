class ChangeStringToText < ActiveRecord::Migration
  def up
    change_column :applications, :pers_statement, :text
    change_column :applications, :rel_coursework, :text
    change_column :choices, :statement, :text
    change_column :choices, :budget, :text
  end
  def down
    # This might cause trouble if you have strings longer than 255 characters.
    change_column :applications, :pers_statement, :string
    change_column :applications, :rel_coursework, :string
    change_column :choices, :statement, :string
    change_column :choices, :budget, :string
  end
end

