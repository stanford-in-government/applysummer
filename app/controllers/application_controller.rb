class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :set_return_to, :reset_return_to

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_url, alert: exception.message
  end

  # Hack to fix CanCan for Rails 4 strong parameters
  # https://github.com/ryanb/cancan/issues/835
  before_filter do
    resource = controller_name.singularize.to_sym
    method = "#{resource}_params"
    params[resource] &&= send(method) if respond_to?(method, true)
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

    def check_deadline(category, type)
      if Fellowship::Application.config.fellowship.deadlines[category][type] < DateTime.now
        redirect_to root_path, flash: { error: "Deadline is over." }
        true
      else
        false
      end
    end
end
