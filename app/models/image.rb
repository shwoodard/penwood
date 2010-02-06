class Image < ActiveRecord::Base
  has_attached_file :image,
                    :styles => {:thumb => '50x50>'}
  
  acts_as_list :scope => :image_experience_id
end
