module ApplicationsHelper
  def print_status(application)
    if application.incomplete?
      raw("<span class=\"label label-danger\">not submitted</span")
    else
      raw("<span class=\"label label-success\">submitted</span")
    end
  end
end
