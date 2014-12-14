module ApplicationHelper
  def title(page_title)
    content_for :title, page_title.to_s
  end

  def strip_parenthesis_hints(str)
    str.gsub /\ \(.*\)/, '' 
  end
end
