class MainController < ApplicationController
  before_action :authenticate_user!, only: [ :apply, :profile ]

  def index
  end

  def fellowships
  end

  def apply
  end

  def confirmed
  end

  def profile
    @profile = current_user.profile
    if @profile.nil?
      @profile = Profile.new
      @profile.user = current_user
    end
    if params.has_key?(:profile)
      if @profile.update(params.require(:profile).permit(:first_name, :middle_name, :last_name, :local_street, :local_city, :local_state, :local_postal, :perm_street, :perm_city, :perm_state, :perm_postal, :perm_country, :majors, :minors, :class_year, :overall_gpa, :major_gpa))
        flash[:notice] = "Profile successfully saved"
      end
    end
  end
end
