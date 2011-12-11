module ApplicationHelper
  def cms_content_for(key)
    Content.find_by_text_identifier(key).body.html_safe
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
    s = <<-END_S
    <div class="subPictureFrame"><div class="subPictureFrameLiner"><ul class="subpage slideShow">
      #{render :partial => 'partials/image.html.erb', :collection => ss.images}
    </ul></div></div>
    END_S

    s.html_safe
  end
  
  def picture_window(pw)
    s = <<-END_S
    <div class="pictureWindowWpr"><div class="pictureWindowLiner">
      <div class="picture_window">#{ image_tag pw.images.first.image.url }</div>
      <ul class="thumbs">
        #{render :partial => 'partials/thumb_image.html.erb', :collection => pw.images}
      </ul>
    </div></div>
    END_S

    s.html_safe
  end
  
  def quote(qte)
    s = <<-END_S
      <div class="quote">
        <div class="body">#{qte.body}</div>
        <div class="float right author">- #{qte.author}</div>
      </div>
      <div class="clear"></div>
    END_S

    s.html_safe
  end
  
  def quotes
    (@page ? Quote.find_all_by_page_id(@page.id).collect {|qte| quote qte}.join('') : '').html_safe
  end
  
  def full_date(date)
    date.strftime('%B %e, %Y')
  end
  
  def full_time(time)
    time.strftime('%A, %B %e, %Y, %l:%M %p')
  end
  
  def user_status(user)
    status = user.active? ? 'Active' : 'Inactive'
    status = 'Banned' if user.banned?
    status
  end
end
