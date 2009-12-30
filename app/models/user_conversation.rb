class UserConversation < ActiveRecord::Base
  belongs_to :user
  belongs_to :conversation
  validates_presence_of :user_id, :conversation_id
  validates_uniqueness_of :user_id, :scope => :conversation_id
end
