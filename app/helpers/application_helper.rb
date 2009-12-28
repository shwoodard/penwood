module ApplicationHelper
  def cms_content_for(key)
    Content.find_by_text_identifier(key).body
  end
end
