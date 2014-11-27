class Organization < ActiveRecord::Base
  has_many :choices
  CATEGORIES = [ :undefined, :local_state, :dc_national, :international ]
  enum category: CATEGORIES
end
