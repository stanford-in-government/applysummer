class Document < ActiveRecord::Base
  belongs_to :user
  CATEGORIES = [ :other, :transcript, :cv]
  enum category: CATEGORIES
end
