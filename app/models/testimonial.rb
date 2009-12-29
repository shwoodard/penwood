class Testimonial < ActiveRecord::Base
  acts_as_list
  
  validates_presence_of :body, :name
end
