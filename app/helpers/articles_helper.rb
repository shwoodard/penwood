module ArticlesHelper
  def render_article_by_type(article)
    case article
    when MyArticle
      render :partial => 'articles/my_article.html.erb', :locals => {:article => article}
    when OtherArticle
      render :partial => 'articles/other_article.html.erb', :locals => {:article => article}
    end
  end
end
