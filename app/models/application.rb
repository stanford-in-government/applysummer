class Application < ActiveRecord::Base
  before_save :generate_rec_code
  validates :category, :user_id, presence: true

  belongs_to :user
  has_many :choices, dependent: :destroy

  STATUSES = [ :incomplete, :completed, :archived ]
  CATEGORIES = [ :fellowship ]

  enum status: STATUSES
  enum category: CATEGORIES

  def has_personal_statement?
    !pers_statement.nil? && pers_statement.size > 0
  end

  def has_relevant_coursework?
    !rel_coursework.nil? && rel_coursework.size > 0
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
      { id: choice.organization_id, statement: choice.statement, budget: choice.budget }
    end
  end

  def update_choices_from_frontend(hash)
    choices = hash.each_with_index.map do |c, i|
      { organization_id: c['id'], statement: c['statement'], budget: c['budget'], rank: i }
    end
    update_choices(choices)
  end

  def update_choices(new_choices)
    self.choices.destroy_all
    new_choices.each do |c|
      choice = Choice.new(c)
      choice.application = self
      choice.save
    end
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
  end
end
