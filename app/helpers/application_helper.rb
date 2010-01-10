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
  
  def quote(qte)
    s = <<-END_S
      <div class="quote">
        <div class="float">#{image_tag('gbl_qte-left.gif')}</div><div class="body">#{qte.body}<div class="quoteWpr">#{image_tag('gbl_qte-right.gif', :class => 'rightQuote')}</div></div>
        <div class="float right author">- #{qte.author}</div>
      </div>
      <div class="clear"></div>
    END_S
  end
  
  def quotes
    @page ? Quote.find_all_by_page_id(@page.id).collect {|qte| quote qte}.join('') : ''
  end
end
