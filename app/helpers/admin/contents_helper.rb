module Admin::ContentsHelper
  def page_display(page)
    s = ''
    s << page.path
    s << " (#{page.title})" if page.title
    s
  end
end
