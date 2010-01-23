class Image < ActiveRecord::Base
  has_attached_file :image,
                    :styles => {:thumb => '80x80>'}
end
