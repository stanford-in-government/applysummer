class Application < ActiveRecord::Base
  before_save :generate_rec_code
  validates :category, :user_id, presence: true

  belongs_to :user
  has_many :choices

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
