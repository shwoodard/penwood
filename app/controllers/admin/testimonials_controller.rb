class Admin::TestimonialsController < Admin::AdminController
  def index
    @testimonials = Testimonial.all(:order => :position)
  end

  def show
    @testimonial = Testimonial.find(params[:id])
  end

  def new
    @testimonial = Testimonial.new
  end

  def create
    @testimonial = Testimonial.new(params[:testimonial])
    if @testimonial.save
      flash[:notice]  = 'You have successfully created a testimonial.'
      redirect_to :action => 'show', :id => @testimonial
    else
      render :action => 'new'
    end
  end

  def edit
    @testimonial = Testimonial.find(params[:id])
  end

  def update
    @testimonial = Testimonial.find(params[:id])
    if @testimonial.update_attributes(params[:testimonial])
      flash[:notice] = 'You have successfully updated the testimonial.'
      redirect_to :action => 'show', :id => @testimonial
    else
      render :action => 'edit'
    end
  end

  def destroy
    testimonial = Testimonial.find(params[:id])
    testimonial.destroy
    flash[:notice] = 'You have delete a testimonial.'
    redirect_to :action => 'index'
  end
end
