class ArticlesController < ApplicationController
  def index
    @articles = Article.paginate(:all, :page => (params[:page] || 1))
  end
  
  def show
    @article = MyArticle.find(params[:id])
  end
end
