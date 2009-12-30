class Group < ActiveRecord::Base
  has_many :user_groups, :dependent => :destroy
end
