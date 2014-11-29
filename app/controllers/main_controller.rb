class MainController < ApplicationController
  before_action :authenticate_user!, only: [ :apply, :apply_to, :statement, :profile, :document ]
  before_action :get_application, only: [ :apply_to, :statement ]

  def index
  end

  def apply
    @categories = Application::CATEGORIES
    application = current_user.applications.where("status <> ?", Application.statuses[:archived]).take
    if application
      puts application.category
      redirect_to apply_to_path(application.category)
    end
  end

  def apply_to
    @profile_exists = current_user.has_profile?
    @resume_exists = current_user.has_resume?
    @transcript_exists = current_user.has_transcript?
    @personal_statement_exists = @application.has_personal_statement?
    @relevant_coursework_exists = @application.has_relevant_coursework?
    @ranking_exists = @application.choices_filled?
    @ranking_submitted = @application.completed?
  end

  def statement
    if params.has_key?(:application)
      if @application.update(application_params)
        flash[:notice] = "Responses successfully saved."
        redirect_to apply_to_path(@category)
      end
    end
  end

  def confirmed
  end

  def profile
    if params.has_key?(:redirect)
      session[:return_to] = request.referer
    end

    @profile = current_user.profile
    if @profile.nil?
      @profile = Profile.new
      @profile.user = current_user
    end

    if params.has_key?(:profile)
      if @profile.update(profile_params)
        if session[:return_to].nil?
          flash.now[:notice] = "Profile successfully saved."
        else
          flash[:notice] = "Profile successfully saved."
          redirect_to session.delete(:return_to)
        end
      end
    end
  end

  def document
    @documents = current_user.documents
    @document = Document.new
    @document.user = current_user
    if params.has_key?(:document)
      if @document.update(document_params)
        flash.now[:notice] = "#{@document.file_file_name} successfully uploaded."
        @document = Document.new
        @document.user = current_user
      end
    end
  end

  private

    def get_application
      @category = params[:category]
      @application = Application.get_or_create_current_application(current_user, @category)
    end

    def profile_params
      params.require(:profile).permit(:first_name, :middle_name, :last_name, :local_street, :local_city, :local_state, :local_postal, :perm_street, :perm_city, :perm_state, :perm_postal, :perm_country, :majors, :minors, :class_year, :overall_gpa, :major_gpa)
    end

    def document_params
      params.require(:document).permit(:file, :category)
    end

    def application_params
      params.require(:application).permit(:pers_statement, :rel_coursework)
    end
end
