class ChangeRecStringToText < ActiveRecord::Migration
  def up
    change_column :recommendations, :text, :text
  end
  def down
    # This might cause trouble if you have strings longer than 255 characters.
    change_column :recommendations, :text, :string
  end
end
