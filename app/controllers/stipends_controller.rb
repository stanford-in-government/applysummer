class StipendsController < ApplicationController
  before_action :authenticate_user!, only: [ :questions ]
  before_action :get_application, only: [ :questions ]

  def index
  end

  def questions
    check_deadline(:stipend, :second)

    @internship = @application.internship
    if @internship.nil?
      @internship = Internship.new
      @internship.application = @application
    end

    if params.has_key?(:internship)
      if @internship.update(internship_params)
        redirect_to session[:return_to], notice: "Internship details successfully saved."
      end
    end
  end

  private
    def get_application
      @application = Application.get_or_create_current_application(current_user, :stipend)
    end

    def internship_params
      params.require(:internship).permit(:application_id, :name, :city, :country, :supervisor_name, :supervisor_title, :supervisor_email, :supervisor_phone, :faculty_name, :at_home, :financial_aid, :unpaid, :minimum_length, :fulltime, :travel_warning, :political, :social_service, :category, :related_to, :work_scope, :relevance, :reason, :budget)
    end
end
