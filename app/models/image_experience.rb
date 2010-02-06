class ImageExperience < ActiveRecord::Base
  has_many :images, :dependent => :destroy, :order => :position
  belongs_to :page
  accepts_nested_attributes_for :images, :reject_if => Proc.new {|image_attributes| image_attributes['title'].blank? }, :allow_destroy => true
  
  class << self
    def new_by_type(type, params)
      type.constantize.new(params)
    end
  end
end
