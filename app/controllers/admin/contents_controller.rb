class Admin::ContentsController < Admin::AdminController
  before_filter :require_super_user, :only => [:new, :create]
  
  def index
    # TODO
  end
  
  def show
    @content = Content.find(params[:id])
  end
  
  def new
    @content = Content.new
  end
  
  def create
    @content = Content.new(params[:content])
    if @content.save
      flash[:notice] = 'You have successfully added a new artifact to the content management system (cms).'
      redirect_to :action => 'show', :id => @content
    else
      render :action => 'new'
    end
  end
  
  def edit
    @content = Content.find(params[:id])
  end
  
  def update
    @content = Content.find(params[:id])
    if @content.update_attributes(params[:content])
      flash[:notice] = 'You have successfully updated an artifact in the content management system (cms).'
      redirect_to :action => 'show', :id => @content
    else
      render :action => 'edit'
    end
  end
  
  def destroy
    content = Content.find(params[:id])
    content.destroy
    flash[:notice] = 'You have successfully removed this content from the cms.'
    redirect_to :action => 'index'
  end
end
