class Profile < ActiveRecord::Base
  belongs_to :user
  validates :sunetid, :suid, :first_name, :last_name, :local_street, :local_city, :local_state,
  :local_postal, :perm_street, :perm_city, :perm_state, :perm_country,
  :perm_postal, :majors, :class_year, :overall_gpa, :major_gpa, presence: true
  validates_numericality_of :overall_gpa, :major_gpa, greater_than_or_equal_to: 0.0, less_than_or_equal_to: 4.3
  validates_numericality_of :class_year, only_integer: true
  validates_numericality_of :suid, only_integer: true
  after_commit :update_user_name

  def full_name
    if middle_name.blank?
      "#{first_name} #{last_name}"
    else
      "#{first_name} #{middle_name} #{last_name}"
    end
  end

  def local_address
    "#{local_street}
    #{local_city}, #{local_state} #{local_postal}"
  end

  def perm_address
    if perm_country == 'US'
      "#{perm_street}
      #{perm_city}, #{perm_state} #{perm_postal}"
    else
      "#{perm_street}
      #{perm_city}, #{perm_state}
      #{Country[perm_country]} #{perm_postal}"
    end
  end

  # Collection of class years for populating dropdown menu
  # Overly generous in case of edge cases
  def get_years
    year = Time.now.year
    (year-1..year+5)
  end

  private

  def update_user_name
    self.user.name = full_name
    self.user.save
  end
end
