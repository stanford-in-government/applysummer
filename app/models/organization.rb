class Organization < ActiveRecord::Base
  has_many :choices

  # Do not change the ordering or delete. Append only!
  CATEGORIES = [ :undefined, :international, :dc_national, :local_state, :local_county ]

  enum category: CATEGORIES
  validates :name, :city, presence: true

  has_attached_file :logo, styles: {thumb: "150x150#"}
  validates_attachment_content_type :logo, content_type: ['image/png', 'image/jpeg']

  def full_city
    state.blank? ? city : "#{city}, #{state}"
  end

  class << self
    def category_tuples
      where(active: true).distinct.pluck(:category).sort.map do |index|
        category = CATEGORIES[index]
        [ category, human_attribute_name(category) ]
      end
    end
  end
end
