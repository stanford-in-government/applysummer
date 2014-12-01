class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :documents, dependent: :destroy
  has_many :applications, dependent: :destroy
  has_one :profile, dependent: :destroy

  # Defaults to applicant
  ROLES = [ :applicant, :reader, :moderator, :admin ]

  enum role: ROLES

  def has_profile?
    !profile.nil?
  end

  def has_resume?
    documents.where(category: Document.categories[:resume]).count > 0
  end

  def has_transcript?
    documents.where(category: Document.categories[:transcript]).count > 0
  end

  def has_completed_applications?
    applications.where(status: Application.statuses[:completed]).count > 0
  end
end
