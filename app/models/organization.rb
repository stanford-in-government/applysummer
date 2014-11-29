class Organization < ActiveRecord::Base
  has_many :choices
  CATEGORIES = [ :undefined, :local_state, :dc_national, :international ]
  enum category: CATEGORIES
  validates :name, :city, presence: true

  has_attached_file :logo, styles: {thumb: "150x150#"}
  validates_attachment_content_type :logo, content_type: ['image/png', 'image/jpeg']

  def full_city
    state.blank? ? city : "#{city}, #{state}"
  end

  class << self
    def category_tuples
      uniq.pluck(:category).sort.map do |index|
        category = CATEGORIES[index]
        [ category, human_attribute_name(category) ]
      end
    end
  end
end
