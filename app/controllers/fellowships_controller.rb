class FellowshipsController < ApplicationController
  before_action :authenticate_user!, only: [ :rank, :save_choices ]
  before_action :get_application, only: [ :rank, :save_choices ]
  before_action :get_fellowships, only: [ :index, :rank ]
  before_action :check_fellowship_deadline, only: [ :rank, :save_choices ]

  def index
  end

  def rank
    @choices = @application.choices_for_frontend
    @num_selected = Fellowship::Application.config.fellowship.num_selected
    @num_applied = Fellowship::Application.config.fellowship.num_applied
  end

  def save_choices
    return render text: 'Your choices have already been submitted.', status: :bad_request if @application.completed? || @application.archived?

    @application.update_choices_from_frontend(JSON.parse(params[:json]))

    if params[:type] == 'submit'
      unless @application.choices_filled?
        return render text: 'You must provide all responses and rank at least one fellowship before you can submit.', status: :bad_request
      end

      @application.completed!
      flash[:notice] = 'Your fellowship preferences have been submitted!'
    end
    render nothing: true, status: :ok
  end

  private
    def check_fellowship_deadline
      check_deadline(:fellowship, :application)
    end

    def get_application
      @application = Application.get_or_create_current_application(current_user, :fellowship)
    end

    def get_fellowships
      @fellowships = Organization.where(active: true).all.order(category: :asc, name: :asc)
      @categories = Organization.category_tuples
    end
end
