class Conversation < ActiveRecord::Base
  has_many :conversation_entries
  has_many :user_conversations
  has_many :users, :through => :user_conversations do 
    def creator
      find(:first, :conditions => 'user_conversations.author = 1')
    end
  end
  
  accepts_nested_attributes_for :users
  
  validates_presence_of :title
  
  attr_accessor :potential_participants
  
  def potential_participants
    @potential_participants ||= (User.basic_admin + users.creator.groups.collect {|group| group.users}).flatten.reject {|user| users.include?(user)}
  end
  
  def deliver_invitations!
    # Deliver conversation invitations
  end
end
