class Profile < ActiveRecord::Base
  belongs_to :user
  validates :first_name, :last_name, :local_street, :local_city, :local_state,
  :local_postal, :perm_street, :perm_city, :perm_state, :perm_country,
  :perm_postal, :majors, :class_year, :overall_gpa, :major_gpa, presence: true

  def full_name
    if middle_name.blank?
      "#{first_name} #{last_name}"
    else
      "#{first_name} #{middle_name} #{last_name}"
    end
  end

  # Collection of class years for populating dropdown menu
  # Overly generous in case of edge cases
  def get_years
    year = Time.now.year
    (year-1..year+5)
  end
end
