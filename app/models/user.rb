class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :documents, dependent: :destroy
  has_many :applications, dependent: :destroy
  has_one :profile, dependent: :destroy

  validates :email, format: { with: /\b[A-Z0-9._%a-z\-]+@stanford\.edu\z/,
                              message: "must be a stanford.edu account" }

  # Defaults to applicant
  ROLES = [ :applicant, :reader, :moderator, :admin ]

  # Only applies to readers because moderators and admins have full read permissions
  PERMISSIONS = [ :no_permission, :fellowship, :stipend, :international, :dc_national, :local_state, :local_county ]

  enum role: ROLES
  enum permission: PERMISSIONS

  def sunetid
    has_profile? ? profile.sunetid : ''
  end

  def has_profile?
    !profile.nil?
  end

  def has_resume?
    documents.where(category: Document.categories[:resume]).count > 0
  end

  def has_transcript?
    documents.where(category: Document.categories[:transcript]).count > 0
  end

  def has_insurance?
    documents.where(category: Document.categories[:insurance]).count > 0
  end

  def has_completed_applications?
    applications.where(status: Application.statuses[:completed]).count > 0
  end
end
