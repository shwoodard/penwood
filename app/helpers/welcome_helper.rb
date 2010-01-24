module WelcomeHelper
  def make_site_map(page, i = 0)
    sm = ""
    sm << "<div>#{tabs(i)}#{link_to page.title, page.path}</div>" if page.title
    page.sub_pages.each {|sb| sm << make_site_map(sb, i + 1)}
    sm
  end
  
  def tabs(n)
    ts = ""
    (0..n).each { ts << "&nbsp;&nbsp;&nbsp;&nbsp;" }
    ts
  end
end
