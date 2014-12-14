class MainController < ApplicationController
  before_action :authenticate_user!, only: [ :apply, :apply_to, :statement, :profile, :document ]
  before_action :get_application, only: [ :apply_to, :statement ]

  def index
  end

  def confirmed
  end

  def faq
  end

  def apply
    @categories = Application::CATEGORIES
    if Fellowship::Application.config.fellowship.restrict_single_application
      application = current_user.applications.where("status <> ?", Application.statuses[:archived]).take
      if application
        redirect_to apply_to_path(application.category)
      end
    end
  end

  def apply_to
    # General
    @profile_exists = current_user.has_profile?
    @personal_statement_exists = @application.has_personal_statement?
    @relevant_coursework_exists = @application.has_relevant_coursework?
    @rec_exists = @application.has_recommendations?
    @completed = @application.completed?

    # Fellowship
    @num_applied = Fellowship::Application.config.fellowship.num_applied
    @resume_exists = current_user.has_resume?
    @transcript_exists = current_user.has_transcript?
    @ranking_exists = @application.choices_filled?
    @ranking_submitted = @application.completed?

    # Stipend
    @insurance_exists = current_user.has_insurance?
    @internship_exists = !@application.internship.nil?
    if @category.to_sym == :stipend && @insurance_exists && @internship_exists && @profile_exists && @personal_statement_exists && @relevant_coursework_exists
      @application.completed!
      @application.save
      @completed = true
    end

    # Always render category-specific application checklist
    render template: "#{@category.to_s.pluralize}/apply_to"
  end

  def statement
    if params.has_key?(:application) &&  @application.update(application_params)
      redirect_to apply_to_path(@category), notice: "Responses successfully saved."
      return
    end

    # Always render category-specific statement page
    render template: "#{@category.to_s.pluralize}/statement"
  end

  def rec
    @application = Application.where(rec_code: params[:rec_code]).take
    if @application.nil?
      redirect_to root_path, flash: { error: 'Invalid recommendation code.' }
      return
    end

    @rec = Recommendation.new
    @rec.application = @application
    if params.has_key?(:recommendation) && @rec.update(recommendation_params)
      redirect_to root_path, notice: 'Recommendation received.'
      return
    end

    # Renders category-specific recommendation form if it exists
    template_name = "#{@application.category.to_s.pluralize}/rec"
    if template_exists?(template_name)
      render template: template_name
    end
  end

  def profile
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
          redirect_to session[:return_to], notice: "Profile successfully saved."
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

    def recommendation_params
      params.require(:recommendation).permit(:letter, :text, :email, :name)
    end
end
