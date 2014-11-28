class MainController < ApplicationController
  before_action :authenticate_user!, only: [ :apply, :profile, :document ]

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
      if @profile.update(profile_params)
        flash.now[:notice] = "Profile successfully saved."
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
      end
    end
  end

  private

    def profile_params
      params.require(:profile).permit(:first_name, :middle_name, :last_name, :local_street, :local_city, :local_state, :local_postal, :perm_street, :perm_city, :perm_state, :perm_postal, :perm_country, :majors, :minors, :class_year, :overall_gpa, :major_gpa)
    end

    def document_params
      params.require(:document).permit(:file, :category)
    end
end
