class TestimonialsController < ApplicationController
  def index
    @testimonials = Testimonal.all(:order => :position)
  end
end
