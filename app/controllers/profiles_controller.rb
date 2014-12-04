class ProfilesController < ApplicationController
  before_action :set_profile, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!
  load_and_authorize_resource

  respond_to :html

  def index
    @profiles = Profile.all
    respond_with(@profiles)
  end

  def show
    respond_with(@profile)
  end

  def new
    @profile = Profile.new
    respond_with(@profile)
  end

  def edit
  end

  def create
    @profile = Profile.new(profile_params)
    @profile.save
    respond_with(@profile)
  end

  def update
    @profile.update(profile_params)
    respond_with(@profile)
  end

  def destroy
    @profile.destroy
    respond_with(@profile)
  end

  private
    def set_profile
      @profile = Profile.find(params[:id])
    end

    def profile_params
      params.require(:profile).permit(:user_id, :first_name, :middle_name, :last_name, :local_street, :local_city, :local_state, :local_postal, :perm_street, :perm_city, :perm_state, :perm_country, :perm_postal, :majors, :minors, :class_year, :overall_gpa, :major_gpa)
    end
end
