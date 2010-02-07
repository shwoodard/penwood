class Conversation < ActiveRecord::Base
  has_many :conversation_entries, :dependent => :destroy
  has_many :user_conversations, :dependent => :destroy
  has_many :users, :through => :user_conversations do 
    def creator
      find(:first, :conditions => 'user_conversations.creator = 1')
    end
    
    def non_creators
      find(:all, :conditions => 'user_conversations.creator = 0')
    end
  end
  
  accepts_nested_attributes_for :user_conversations
  accepts_nested_attributes_for :conversation_entries
  
  validates_presence_of :subject
  validate :enough_participants
  
  after_create :deliver_invitations
  
  def potential_participants
    @potential_participants ||= (User.basic_admin + users.creator.groups.collect {|group| group.users}).flatten.reject {|user| users.include?(user)}
  end
  
  def deliver_invitations
    users.non_creators.each do |user|
      ContactNotifier.deliver_new_conversation_email(self, user)
    end
  end
  
  def enough_participants
    errors.add_to_base('You must have at least one other participant other than yourself.') unless user_conversations.size > 1
  end
  
  class << self
    def new_messages?(user)
      n_new_messages(user) > 0
    end
    
    def n_new_messages(user)
      user.conversations.find_all {|conversation| conversation.conversation_entries.any? {|ce| ce.unread?(user)}}.size
    end
  end
end
