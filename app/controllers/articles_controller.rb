class ArticlesController < ApplicationController
  def index
    @articles = Article.paginate(:all, :page => (params[:page] || 1), :order => :position)
  end
  
  def show
    @article = Article.find(params[:id])
  end
end
