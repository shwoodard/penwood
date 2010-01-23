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
  
  def image_experience(ie)
    case ie
    when ImageSlideShow
      slide_show(ie)
    when PictureWindow
      picture_window(ie)
    end
  end
  
  def slide_show(ss)
    <<-END_S
    <div class="subPictureFrame"><div class="subPictureFrameLiner"><ul class="subpage slideShow">
      #{render :partial => 'partials/image.html.erb', :collection => ss.images}
    </ul></div></div>
    END_S
  end
  
  def picture_window(pw)
    <<-END_S
    <div class="pictureWindowWpr"><div class="pictureWindowLiner">
      <div class="picture_window">#{ image_tag pw.images.first.image.url }</div>
      <ul class="thumbs">
        #{render :partial => 'partials/thumb_image.html.erb', :collection => pw.images}
      </ul>
    </div></div>
    END_S
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
  
  def full_date(date)
    date.strftime('%B %e, %Y')
  end
  
  def user_status(user)
    status = user.active? ? 'Active' : 'Inactive'
    status = 'Banned' if user.banned?
    status
  end
end
