module ApplicationHelper
  def cms_content_for(key)
    Content.find_by_text_identifier(key).body
  end
  
  def page_display(page)
    s = ''
    s << page.path
    s << " (#{page.title})" if page.title
    s
  end
end
