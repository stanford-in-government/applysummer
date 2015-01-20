class RecommendationsController < ApplicationController
  before_action :set_recommendation, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!
  load_and_authorize_resource

  respond_to :html

  def index
    respond_with(@recommendations)
  end

  def show
    respond_with(@recommendation) do |format|
      format.pdf do
        if @recommendation.text.blank?
          redirect_to @recommendation.letter.url
        else
          @user = @recommendation.application.user
          render pdf: "Recommendation for #{@user.sunetid} (#{@user.name})",
                 page_size: 'Letter',
                 margin: {
                  top: 20
                 }
        end
      end
    end
  end

  def new
    @recommendation = Recommendation.new
    respond_with(@recommendation)
  end

  def edit
  end

  def create
    @recommendation = Recommendation.new(recommendation_params)
    @recommendation.save
    respond_with(@recommendation)
  end

  def update
    @recommendation.update(recommendation_params)
    respond_with(@recommendation)
  end

  def destroy
    @recommendation.destroy
    respond_with(@recommendation)
  end

  private
    def set_recommendation
      @recommendation = Recommendation.find(params[:id])
    end

    def recommendation_params
      params.require(:recommendation).permit(:email, :name, :application_id, :text)
    end
end
