class Admin::ImageSlideShowsController < Admin::AdminController
  before_filter :require_super_user, :only => [:index, :new, :create, :destroy]
  
  def index
    @slide_shows = ImageSlideShow.all
  end
  
  def show
    @slide_show = ImageSlideShow.find(params[:id])
  end
  
  def new
    @slide_show = ImageSlideShow.new
    @slide_show.images.build
  end
  
  def create
    @slide_show = ImageSlideShow.new(params[:image_slide_show])
    if @slide_show.save
      add_image and return if params[:commit] == 'Save and Add image'
      flash[:notice] = 'You have sucessfully created the slide show.'
      redirect_to :action => 'show', :id => @slide_show
    else
      render :action => 'new'
    end
  end
  
  def edit
    @slide_show = ImageSlideShow.find(params[:id])
    @slide_show.images.build
  end
  
  def update
    @slide_show = ImageSlideShow.find(params[:id])
    if @slide_show.update_attributes(params[:image_slide_show])
      add_image and return if params[:commit] == 'Save and Add image'
      flash[:notice] = 'You have successfully updated the image slide show.'
      redirect_to :action => 'show', :id => @slide_show
    else
      render :action => 'edit'
    end
  end
  
  def destroy
    slide_show = ImageSlideShow.find(params[:id])
    slide_show.destroy
    flash[:notice] = 'You have deleted the slide show.'
    redirect_to :action => 'index'
  end
  
  def add_image
    @slide_show.images.build
    render :action => 'edit', :id => @slide_show
  end
end
