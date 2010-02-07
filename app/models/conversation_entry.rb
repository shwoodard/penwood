class ConversationEntry < ActiveRecord::Base
  belongs_to :conversation
  belongs_to :user

  validates_presence_of :body
  
  after_create :deliver_conversation_updates
  
  serialize :read_by
  
  def read_by
    read_attribute(:read_by) || write_attribute(:read_by, [])
  end
  
  def read_by=(email_address)
    self.read_by << email_address
    self.attributes[:read_by] = self.read_by.uniq
  end
  
  def deliver_conversation_updates
    conversation.users.reject {|u| u == user}.each do |usr|
      ContactNotifier.deliver_conversation_update_email(conversation, self, usr)
    end unless conversation.new_record?
  end
  
  def read?(user)
    read_by.include?(user.email)
  end
  
  def unread?(user)
    !read?(user)
  end
end
