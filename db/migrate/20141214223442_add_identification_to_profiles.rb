class AddIdentificationToProfiles < ActiveRecord::Migration
  def change
    add_column :profiles, :sunetid, :string
    add_column :profiles, :suid, :string
  end
end
