class TestimonialsController < ApplicationController
  def index
    @testimonials = Testimonial.all(:order => :position)
  end
end
