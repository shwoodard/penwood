class Admin::ArticlesController < Admin::AdminController
  def index
    @articles = Article.paginate(:all, :page => params[:page])
  end
  
  def show
    @article = Article.find(params[:id])
  end
  
  def new
    @article = Article.new
  end
  
  def create
    @article = Article.new(params[:article])
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
    if @artlce.save
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
