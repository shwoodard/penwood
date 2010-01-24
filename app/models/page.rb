class Page < ActiveRecord::Base
  has_many :contents
  has_many :image_experiences
  has_many :quotes
  belongs_to :parent, :class_name => 'Page'
  has_many :sub_pages, :class_name => 'Page', :foreign_key => 'parent_id'
  
  validates_uniqueness_of :path, :title
  
  def private?
    title.blank?
  end
  
  def parent_path=(value)
    self.parent = Page.find_by_path(value)
  end
  
  class << self
    def root
      find_by_path('/')
    end
  end
end
