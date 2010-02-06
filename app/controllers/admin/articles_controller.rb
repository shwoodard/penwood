class Admin::ArticlesController < Admin::AdminController
  def index
    @articles = Article.paginate(:all, :page => (params[:page] || 1))
  end
  
  def show
    @article = Article.find(params[:id])
  end
  
  def new
    @article = Article.new
  end
  
  def create
    @article = Article.new_by_type(params[:article].delete(:type), params[:article])
    logger.info "#{@artilce.class}"
    @article.user = current_user unless @artilce.is_a?(OtherArticle)
    if @article.save
      flash[:notice] = 'You have successfully created the reading.'
      redirect_to :action => 'show', :id => @article
    else
      render :action => 'new'
    end
  end
  
  def edit
    @article = Article.find(params[:id])
  end
  
  def update
    @article = Article.find(params[:id])
    if @article.update_attributes(params[:my_article] || params[:other_article])
      flash[:notice] = 'You have successfully updated the reading.'
      redirect_to :action => 'show', :id => @article
    else
      render :action => 'edit'
    end
  end
  
  def destroy
    article = Article.find(params[:id])
    article.destroy
    flash[:notice] = "You have deleted the reading."
    redirect_to :action => 'index'
  end
end
