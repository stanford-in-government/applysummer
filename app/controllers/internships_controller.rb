class InternshipsController < ApplicationController
  before_action :set_internship, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!
  load_and_authorize_resource

  respond_to :html

  def index
    @internships = Internship.all
    respond_with(@internships)
  end

  def show
    respond_with(@internship)
  end

  def new
    @internship = Internship.new
    respond_with(@internship)
  end

  def edit
  end

  def create
    @internship = Internship.new(internship_params)
    @internship.save
    respond_with(@internship)
  end

  def update
    @internship.update(internship_params)
    respond_with(@internship)
  end

  def destroy
    @internship.destroy
    respond_with(@internship)
  end

  private
    def set_internship
      @internship = Internship.find(params[:id])
    end

    def internship_params
      params.require(:internship).permit(:application_id, :name, :city, :country, :supervisor_name, :supervisor_title, :supervisor_email, :supervisor_phone, :faculty_name, :at_home, :financial_aid, :unpaid, :minimum_length, :fulltime, :travel_warning, :political, :social_service, :category, :related_to, :work_scope, :relevance, :reason)
    end
end
