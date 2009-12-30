class ConversationsController < ApplicationController
  before_filter :require_user
  
  def index
    @conversation = current_user.conversations.build
    @conversation.conversation_entries.build
    User.basic_admin.each {|u| @conversation.user_conversations.build(:user => u)}
  end
  
  def new
    @conversation = Conversation.new
    @conversation.user_conversations.build(:user => current_user, :creator => true)
  end
  
  def create
    @conversation = Conversation.new(params[:conversation])
    @conversation.user_conversations.build(:user => current_user)
    if @conversation.save
      flash[:notice] = 'Your conversation has been created.'
      @conversation.deliver_invitations!
      redirect_to @conversation
    else
      # TODO change to new
      render :action => 'index'
    end
  end
end
