class UserGroup < ActiveRecord::Base
  belongs_to :user
  belongs_to :group
  validates_presence_of :user_id, :group_id
  validates_uniqueness_of :user_id, :scope => :group_id
end
