class Conversation < ActiveRecord::Base
  has_many :conversation_entries
  has_many :user_conversations
  has_many :users, :through => :user_conversations do 
    def creator
      find(:first, :conditions => 'user_conversations.creator = 1')
    end
  end
  
  accepts_nested_attributes_for :user_conversations
  accepts_nested_attributes_for :conversation_entries
  
  validates_presence_of :subject
  
  def potential_participants
    @potential_participants ||= (User.basic_admin + users.creator.groups.collect {|group| group.users}).flatten.reject {|user| users.include?(user)}
  end
  
  def deliver_invitations!
    # Deliver conversation invitations
  end
end
