class AdminController < ApplicationController
  before_action :authenticate_user!

  def index
  end

  def stats
    @fellowships = Organization.accessible_by(current_ability, :read)
      .where(active: true)
      .order('category, name')
      .group_by(&:category)

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
end
