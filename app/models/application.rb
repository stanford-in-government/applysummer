class Application < ActiveRecord::Base
  before_save :generate_rec_code
  validates :category, :user_id, presence: true

  belongs_to :user
  has_many :recommendations, dependent: :destroy
  has_many :choices, dependent: :destroy # for fellowship applications
  has_one :internship, dependent: :destroy # for stipend applications

  # Do not change the ordering or delete. Append only!
  STATUSES = [ :incomplete, :completed, :archived ]
  CATEGORIES = [ :fellowship, :stipend ]

  enum status: STATUSES
  enum category: CATEGORIES

  def has_personal_statement?
    !pers_statement.blank?
  end

  def has_relevant_coursework?
    !rel_coursework.blank?
  end

  def has_recommendations?
    recommendations.count > 0
  end

  def belongs_to_category(category)
    return true if self.category == category.to_s
    choices.each do |choice|
      return true if choice.organization.category == category.to_s
    end
    false
  end

  def generate_rec_code
    self.rec_code ||= loop do
      random_token = SecureRandom.hex(10)
      break random_token unless self.class.exists?(rec_code: random_token)
    end
  end

  def ordered_choices
    self.choices.order(:rank)
  end

  def choices_for_frontend
    ordered_choices.map do |choice|
      { id: choice.organization_id, statement: choice.statement, budget: choice.budget, at_home: choice.at_home }
    end
  end

  def update_choices_from_frontend(hash)
    choices = hash.each_with_index.map do |c, i|
      { organization_id: c['id'], statement: c['statement'], budget: c['budget'], rank: i, at_home: c['at_home'] }
    end
    update_choices(choices)
  end

  def update_choices(new_choices)
    Choice.transaction do
      self.choices.destroy_all
      new_choices.each do |c|
        choice = Choice.new(c)
        choice.application = self
        return false unless choice.save
      end
    end
    true
  end

  def choices_filled?
    limit = Fellowship::Application.config.fellowship.num_applied
    self.ordered_choices.all.limit(limit).each do |choice|
      return false if choice.statement.blank? || choice.budget.blank?
    end
    self.choices.count > 0
  end

  class << self
    def get_or_create_current_application(user, category)
      Application.where(user: user, category: Application.categories[category])
                 .where("status <> ?", Application.statuses[:archived])
                 .first_or_create do |application|
        application.user = user
        application.category = Application.categories[category]
        application.status = Application.statuses[:incomplete]
      end
    end

    def to_csv(options = {})
      CSV.generate(options) do |csv|
        csv << ['First Name', 'Last Name', 'SUID', 'Email', 'Class', 'Majors']
        all.each do |app|
          user = app.user
          profile = user.profile
          csv << [profile.first_name, profile.last_name, profile.suid, user.email, profile.class_year, profile.majors]
        end
      end
    end
  end
end
