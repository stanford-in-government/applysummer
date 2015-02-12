class AdminController < ApplicationController
  before_action :authenticate_user!
  before_action :get_fellowships, only: [:fellowships, :stats]

  def index
    render status: :forbidden unless current_user.can_read?
  end

  def become
    render status: :forbidden unless current_user.admin?
    sign_in(:user, User.find(params[:user_id]), bypass: true)
    redirect_to root_url
  end

  def debug_applications
    render status: :forbidden unless current_user.admin?
    @app = Application.where(status: Application.statuses[:completed])
      .where(category: Application.categories[:fellowship])
      .includes(:choices)
      .all
  end

  # For debugging duplicated choices bug
  def debug
    render status: :forbidden unless current_user.admin?
    @app = Application.where(category: Application.categories[:fellowship])
  end

  def list_emails
    category = params[:category]
    applications = Application.accessible_by(current_ability, :read)
      .includes(:user)
      .where.not(status: Application.statuses[:archived])
      .where(category: Application.categories[category])
      .all

    emails = applications.map {|app| app.user.email}
    render text: emails.join(', ')
  end

  def export_applicants
    category = params[:category]
    @applications = Application.accessible_by(current_ability, :read)
      .includes(user: [:profile])
      .where(status: Application.statuses[:completed])
      .where(category: Application.categories[category])
      .all

    respond_to do |format|
      format.csv { render text: @applications.to_csv }
      format.xls { render text: @applications.to_csv(col_sep: "\t") }
    end
  end

  def fellowships
    id = params[:id]

    unless id.blank?
      @fellowship = Organization.accessible_by(current_ability, :read).find(id)
    end

    @choices = Choice.accessible_by(current_ability, :read)
      .includes(:organization, application: [:recommendations, user: [:documents, :profile]])
      .joins(:organization)
      .where('organizations.id' => id)
      .order(:rank)
      .all

    @emails = @choices.map do |choice|
      choice.application.user.email
    end
  end

  def stipends
    @applications = Application.accessible_by(current_ability, :read)
      .where(category: Application.categories[:stipend])
      .includes(user: [:documents, :profile])
      .all
  end

  def stats
    @incompletes = Choice.accessible_by(current_ability, :read)
      .joins(:application)
      .where(applications: { status: Application.statuses[:incomplete] })
      .group(:organization_id)
      .count
    @completes = Choice.accessible_by(current_ability, :read)
      .joins(:application)
      .where(applications: { status: Application.statuses[:completed] })
      .group(:organization_id)
      .count

    @applicants = User.where(role: User.roles[:applicant]).count

    stipends = Application.where(category: Application.categories[:stipend])
    fellowships = Application.where(category: Application.categories[:fellowship])

    @num_stipends = stipends.where(status: Application.statuses[:incomplete]).count
    @num_completed_stipends = stipends.where(status: Application.statuses[:completed]).count
    @num_fellowships = fellowships.where(status: Application.statuses[:incomplete]).count
    @num_completed_fellowships = fellowships.where(status: Application.statuses[:completed]).count
  end

  private
    def get_fellowships
      @fellowships = Organization.accessible_by(current_ability, :read)
        .where(active: true)
        .order('category, name')
        .group_by(&:category)
    end
end
