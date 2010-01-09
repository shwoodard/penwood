class Admin::QuotesController < Admin::AdminController
  before_filter :require_super_user, :only => [:index, :new, :create, :destroy]
  
  def index
    @quotes = Quote.all
  end
  
  def show
    @quote = Quote.find(params[:id])
  end
  
  def new
    @quote = Quote.new
  end
  
  def create
    @quote = Quote.new(params[:quote])
    if @quote.save
      flash[:notice] = "Quote created"
      redirect_to :action => 'show', :id => @quote
    else
      render :action => 'new'
    end
  end
  
  def edit
    @quote = Quote.find(params[:id])
  end
  
  def update
    @quote = Quote.find(params[:id])
    if @quote.update_attributes(params[:quote])
      flash[:notice] = 'The quote has been updated.'
      redirect_to :action => 'show', :id => @quote
    else
      render :action => 'edit'
    end
  end
  
  def destroy
    quote = Quote.find(params[:id])
    quote.destroy
    flash[:notice] = 'The quote has been deleted'
    redirect_to :action => 'index'
  end
end
