class ApplicationsController < ApplicationController
  before_action :set_application, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!
  load_and_authorize_resource

  respond_to :html

  def index
    @applications = Application.all
    respond_with(@applications)
  end

  def show
    respond_with(@application) do |format|
      format.pdf do
        @user = @application.user
        @profile = @user.profile
        @num_applied = Fellowship::Application.config.fellowship.num_applied
        render pdf: "#{@user.sunetid} (#{@user.name}) - #{@application.status}",
               page_size: 'Letter',
               margin: {
                top: 20
               },
               header: {
                spacing: 2,
                html: {
                  template: 'applications/header.pdf.erb'
                }
               },
               show_as_html: params[:debug].present?

      end
    end
  end

  def new
    @application = Application.new
    respond_with(@application)
  end

  def edit
  end

  def create
    @application = Application.new(application_params)
    @application.save
    respond_with(@application)
  end

  def update
    @application.update(application_params)
    respond_with(@application)
  end

  def destroy
    @application.destroy
    if current_user.admin?
      respond_with(@application)
    else
      redirect_to root_url, notice: 'Application deleted.'
    end
  end

  private
    def set_application
      @application = Application.find(params[:id])
    end

    def application_params
      params.require(:application).permit(:category, :status, :rec_code, :user_id)
    end
end
