class MainController < ApplicationController
  before_action :authenticate_user!, only: [ :apply ]

  def index
  end

  def fellowships
  end

  def apply
  end

  def confirmed
  end
end
