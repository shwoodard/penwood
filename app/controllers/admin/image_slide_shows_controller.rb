class Admin::ImageSlideShowsController < Admin::AdminController
  before_filter :require_super_user, :only => [:index, :new, :create, :destroy]
  
  def index
    @experiences = ImageExperience.paginate(:all, :page => (params[:page] || 1))
  end
  
  def show
    @experience = ImageExperience.find(params[:id])
  end
  
  def new
    @experience = ImageExperience.new
    @experience.images.build
  end
  
  def create
    @experience = ImageExperience.new_by_type(params[:image_experience].delete(:type), params[:image_experience])
    if @experience.save
      add_image and return if params[:commit] == 'Save and Add image'
      flash[:notice] = 'Success!'
      redirect_to :action => 'show', :id => @experience
    else
      render :action => 'new'
    end
  end
  
  def edit
    @experience = ImageExperience.find(params[:id])
    @experience.images.build
  end
  
  def update
    @experience = ImageExperience.find(params[:id])
    if @experience.update_attributes(params[:picture_window] || params[:image_slide_show])
      add_image and return if params[:commit] == 'Save and Add image'
      flash[:notice] = 'Success!'
      redirect_to :action => 'show', :id => @experience
    else
      render :action => 'edit'
    end
  end
  
  def destroy
    experience = ImageExperience.find(params[:id])
    experience.destroy
    flash[:notice] = 'You have successfully deleted the artifact.'
    redirect_to :action => 'index'
  end
  
  def add_image
    @experience.images.build
    render :action => 'edit', :id => @experience
  end
end
