class AddAttachmentLetterToRecommendations < ActiveRecord::Migration
  def self.up
    change_table :recommendations do |t|
      t.attachment :letter
    end
  end

  def self.down
    remove_attachment :recommendations, :letter
  end
end
