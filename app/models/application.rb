class Application < ActiveRecord::Base
  belongs_to :user
  has_many :choices

  STATUSES = [ :incomplete, :completed, :archived ]
  CATEGORIES = [ :fellowship ]

  enum status: STATUSES
  enum category: CATEGORIES
end
