module ApplicationHelper
  def title(page_title)
    content_for :title, page_title.to_s
  end

  def strip_parenthesis_hints(str)
    str.gsub /\ \(.*\)/, '' 
  end

  def print_deadline(category, deadline)
    Fellowship::Application.config.fellowship.deadlines[category][deadline].strftime '%B %e'
  end
end
