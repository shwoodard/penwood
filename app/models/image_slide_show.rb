class ImageSlideShow < ActiveRecord::Base
  has_many :images, :dependent => :destroy
  belongs_to :page
  accepts_nested_attributes_for :images, :reject_if => Proc.new {|image_attributes| image_attributes['title'].blank? }, :allow_destroy => true
end
