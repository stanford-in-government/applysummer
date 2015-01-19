class ChoicesController < ApplicationController
  before_action :set_choice, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!
  load_and_authorize_resource

  respond_to :html

  def index
    respond_with(@choices)
  end

  def show
    respond_with(@choice)
  end

  def new
    @choice = Choice.new
    respond_with(@choice)
  end

  def edit
  end

  def create
    @choice = Choice.new(choice_params)
    @choice.save
    respond_with(@choice)
  end

  def update
    @choice.update(choice_params)
    respond_with(@choice)
  end

  def destroy
    @choice.destroy
    respond_with(@choice)
  end

  private
    def set_choice
      @choice = Choice.find(params[:id])
    end

    def choice_params
      params.require(:choice).permit(:rank, :statement, :organization_id, :application_id, :at_home)
    end
end
