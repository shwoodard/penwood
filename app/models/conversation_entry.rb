class ConversationEntry < ActiveRecord::Base
  belongs_to :conversation
  validates_presence_of :body
end
