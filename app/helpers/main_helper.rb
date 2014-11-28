module MainHelper
  def print_status_label(text, css_class)
    text = text.to_s.titleize
    html = "<h4><span class=\"label label-#{css_class}\">#{text}</span></h4>"
    raw(html)
  end
end
