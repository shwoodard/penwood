class Image < ActiveRecord::Base
  has_attached_file :image,
                    :styles => {:thumb => '50x50>'}
end
