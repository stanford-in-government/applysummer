class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :set_return_to, :reset_return_to

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_url, alert: exception.message
  end


  def after_sign_in_path_for(resource)
    if resource.is_a?(User) && !resource.has_profile?
      confirmed_path
    else
      super
    end
  end

  private
    def reset_return_to
      if session[:return_to] == request.original_url
        session[:return_to] = nil
      end
    end

    def set_return_to
      if params.has_key?(:return_to) && !request.referer.blank? && request.original_url != request.referer
        session[:return_to] = request.referer
      end
      @return_to = session[:return_to]
    end
end
